/**
 * OpenStreetMap Nominatim를 사용하여 위도, 경도로 주소 반환
 *  : openstreetmap - 서비스키 없이 위도 경도를 이용한 주소 확인 가능
 * 
* @param {number} lat - 위도
* @param {number} lon - 경도
* @returns {object|null} 변환 결과 객체 또는 변환 실패 시 null
 * 
 */
async function getAddressFromCoordinates(lat, lon) {
	let result = null;
	
	const NOMINATIM_URL = "https://nominatim.openstreetmap.org/reverse";
	// format=json : 응답 형식을 JSON으로 요청
	// lat, lon : 위도, 경도
	// zoom=18 : 주소 상세 수준 (0=국가, 18=거리 수준)
	// addressdetails=1 : 주소의 상세 구성 요소 포함 (예: 도시, 도로, 건물 번호 등)
	const params = new URLSearchParams({
	    format: "json",
	    lat: lat,
	    lon: lon,
	    //zoom: 18,
	    //addressdetails: 1,
	    // email: 'your_email@example.com' // API 사용 정책 준수를 위해 이메일 제공 권장
	});
	const requestUrl = `${NOMINATIM_URL}?${params.toString()}`;
	
	const element = document.querySelector('#loadingLayout');
	if(element) {
		element.style.display = 'block';
	}
	
	try {
		const response = await fetch(requestUrl);
		if (! response.ok) {
			const errorText = await response.text();
			throw new Error(`HTTP error! status: ${response.status}, message: ${errorText}`);
		}
		 
		const data = await response.json();
		
		if (data && data.address) {
			let addressInfo = data.address;
			
			let display_name = data.display_name || 'N/A'; // Nominatim 전체 주소 필드
			let country = addressInfo.country || 'N/A'; // 국가
			let province =addressInfo.state || addressInfo.province || ''; // 도
			let city = addressInfo.city || addressInfo.county || ''; // 시/군
			let borough = addressInfo.borough || ''; // 구
			let suburb = addressInfo.suburb || addressInfo.town || addressInfo.village || ''; // 동/면/리		
			let road = addressInfo.road || ''; // 도로명			
			let building = addressInfo.building || ''; // 건물명 (있는 경우)
			let house_number = addressInfo.house_number || ''; // 건물 번호
			let postcode = addressInfo.postcode || ''; // 건물 번호			
			
			result = {
				display_name: display_name,
				country: country,
				province: province,
				city: city,
				borough: borough,
				suburb: suburb,
				road: road,
				building: building,
				house_number: house_number,
				postcode: postcode
			}
		}

	} catch (err) {
		 console.error(err);
	} finally {
		if(element) {
			element.style.display = 'none';
		}
	}
	
	return result;
}

/**
 * 브라우저의 위치 정보(코오더넛)를 위도 경도의 정보를 Promise 객체로 반환하는 함수
 * 
 * @returns {object|null} 위치정보의 위도 경도 반환 객체 ({ latitude, longitude } 또는 변환 실패 시 null
 */
async function getCurrentLocation() {
    return new Promise((resolve) => {
        // Geolocation API 지원 여부
        if (!navigator.geolocation) {
            alert('이 브라우저는 위치 정보를 지원하지 않습니다.');
            resolve(null);
            return;
        }

        // 위치 정보 가져오기 시도
        // options:
        //   enableHighAccuracy: true - 더 정확한 위치를 요청 (배터리 소모 증가)
        //   timeout: 5000 - 위치 정보를 가져오는 최대 시간 (밀리초)
        //   maximumAge: 0 - 캐시된 위치를 사용하지 않고 항상 새 위치를 가져옴
        navigator.geolocation.getCurrentPosition(
            (position) => {
                // 위치 정보 가져오기 성공
                const latitude = position.coords.latitude;
                const longitude = position.coords.longitude;
                // console.log(`위치 정보 : Latitude ${latitude}, Longitude ${longitude}`);
                resolve({ latitude, longitude });
            },
            (error) => {
                // 위치 정보 가져오기 실패
                // console.error(`위치 정보 가져오기 실패 : ${error.code} - ${error.message}`);
                let errorMessage = '위치 정보를 가져오는 데 실패했습니다: ';
                switch (error.code) {
                    case error.PERMISSION_DENIED:
                        errorMessage += '위치 정보 접근이 거부되었습니다. 브라우저 설정에서 위치 권한을 허용해주세요.';
                        break;
                    case error.POSITION_UNAVAILABLE:
                        errorMessage += '위치 정보를 사용할 수 없습니다 (네트워크 문제 또는 위성 신호 없음).';
                        break;
                    case error.TIMEOUT:
                        errorMessage += '위치 정보를 가져오는 데 시간이 초과되었습니다. 다시 시도해주세요.';
                        break;
                    case error.UNKNOWN_ERROR:
                        errorMessage += '알 수 없는 오류가 발생했습니다.';
                        break;
                }
                alert(errorMessage);
                resolve(null);
            },
            {
                enableHighAccuracy: true,
                timeout: 5000,
                maximumAge: 0,
            }
        );
    });
}

/**
- 좌표에서 GRID는 일반적으로 격자(grid)를 의미하며, 
  지도나 좌표 체계에서 공간을 일정한 간격으로 나눈 격자 형태의 구조 
		 
 * 위도/경도와 기상청 격자 좌표(nx, ny) 간의 변환을 수행
 * toGrid : 위도, 경도를 격좌 좌표로 변환
 * toLatLng : 격좌 좌표를 위도 경도로 변한
 * 
 * @param {object} options - 변환 옵션 객체
 * @param {string} options.mode - 변환 모드 ('toGrid' 또는 'toLatLng'),
 * @param {number} [options.lat] - 입력 위도 (toGrid 모드에서만 사용)
 * @param {number} [options.lng] - 입력 경도 (toGrid 모드에서만 사용)
 * @param {number} [options.nx] - 입력 격자 X 좌표 (toLatLng 모드에서만 사용)
 * @param {number} [options.ny] - 입력 격자 Y 좌표 (toLatLng 모드에서만 사용)
 * @returns {object|null} 변환 결과 객체 ({ nx, ny } 또는 { lat, lng }) 또는 변환 실패 시 null
*/
function convertCoords(options) {
    const RE = 6371.00877; // 지구 반경 (km)
    const GRID = 5.0;      // 격자 간격 (km)
    const SLAT1 = 30.0;    // 표준 위도 1
    const SLAT2 = 60.0;    // 표준 위도 2
    const OLON = 126.0;    // 기준 경도 (동경)
    const OLAT = 38.0;     // 기준 위도 (북위)
    const XO = 43;         // 원점 X 좌표
    const YO = 136;        // 원점 Y 좌표

    const DEGRAD = Math.PI / 180.0;
    const RADDEG = 180.0 / Math.PI;

    const re = RE / GRID;
    const slat1 = SLAT1 * DEGRAD;
    const slat2 = SLAT2 * DEGRAD;
    const olon = OLON * DEGRAD;
    const olat = OLAT * DEGRAD;

    let sn = Math.tan(Math.PI * 0.25 + slat2 * 0.5) / Math.tan(Math.PI * 0.25 + slat1 * 0.5);
    sn = Math.log(Math.cos(slat1) / Math.cos(slat2)) / Math.log(sn);
    let sf = Math.tan(Math.PI * 0.25 + slat1 * 0.5);
    sf = Math.pow(sf, sn) * Math.cos(slat1) / sn;
    let ro = Math.tan(Math.PI * 0.25 + olat * 0.5);
    ro = re * sf / Math.pow(ro, sn);

    if (options.mode === 'toGrid') {
        // 위도/경도를 격자 좌표로 변환
        const lat = options.lat;
        const lng = options.lng;

        if (typeof lat !== 'number' || typeof lng !== 'number') {
            console.error("Error: 'lat' and 'lng' must be provided for 'toGrid' mode.");
            return null;
        }

        const ra = Math.tan(Math.PI * 0.25 + (lat * DEGRAD) * 0.5);
        const ra_pow_sn = re * sf / Math.pow(ra, sn);

        const theta = (lng * DEGRAD) - olon;
        let x = ra_pow_sn * Math.sin(theta);
        let y = ro - ra_pow_sn * Math.cos(theta);

        const nx = Math.floor(x + XO + 0.5);
        const ny = Math.floor(y + YO + 0.5);

        return { nx, ny };

    } else if (options.mode === 'toLatLng') {
        // 격자 좌표를 위도/경도로 변환
        const nx = options.nx;
        const ny = options.ny;

        if (typeof nx !== 'number' || typeof ny !== 'number') {
            console.error("Error: 'nx' and 'ny' must be provided for 'toLatLng' mode.");
            return null;
        }

        const ra = Math.sqrt(Math.pow(nx - XO, 2) + Math.pow(ny - YO, 2));
        if (ra === 0) { // 0으로 나누는 것 방지
            return null;
        }
        const alat = Math.pow((re * sf / ra), (1.0 / sn));
        const finalLat = 2.0 * Math.atan(alat) - Math.PI * 0.5;

        let alon = 0;
        // atan2의 두 번째 인자는 양수여야 함 (수학적 정의에 따라)
        if (Math.abs(ra) > 1e-9) { // 0으로 나누는 것 방지 (atan2의 두 번째 인자가 0에 가까울 때)
            alon = Math.atan2(nx - XO, -(ny - YO)); // KMA 투영법의 특성상 x, y 축이 일반적인 수학 좌표계와 다름 (y가 위로 갈수록 작아짐)
        }
        const finalLng = (alon * RADDEG) + OLON;

        return { lat: finalLat * RADDEG, lng: finalLng };

    } else {
        console.error("Error: 'mode' must be either 'toGrid' or 'toLatLng'.");
        return null;
    }
}
