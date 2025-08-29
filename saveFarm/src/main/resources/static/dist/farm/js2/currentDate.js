function getCurrentDateTime() {
	const result = {};
	
	// 시스템 현재 시간
	const now = new Date();

	let year = now.getFullYear();
	let month = ('0' + (now.getMonth() + 1)).slice(-2);
	let day = ('0' + now.getDate()).slice(-2);
	let dateString = year + month + day;

	let hour = ('0' + now.getHours()).slice(-2);
	let minute = ('0' + now.getMinutes()).slice(-2);
	let second = ('0' +now.getSeconds()).slice(-2);
	
	result.year = year.toString();
	result.month = month;
	result.day = day;
	result.dateString = dateString;
	result.hour = hour;
	result.minute = minute;
	result.second = second;
	
	return result;
}

function formatDate(date) {
    const pad = (n) => n.toString().padStart(2, '0');
    
    const year = date.getFullYear();
    const month = pad(date.getMonth() + 1);
    const day = pad(date.getDate());
    const hours = pad(date.getHours());
    const minutes = pad(date.getMinutes());
    const seconds = pad(date.getSeconds());

    return `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;
}

function startClock(callback) {
    setInterval(() => {
        const now = new Date();
        const formattedTime = formatDate(now);
        callback(formattedTime);
    }, 1000);
}
