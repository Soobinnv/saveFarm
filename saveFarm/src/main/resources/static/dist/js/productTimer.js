// 마감 임박 구출 상품 타이머
const startTimers = function() {
    $('.deadline-timer').each(function() {
        const $timerEL = $(this);
        
        const deadline = $timerEL.data('deadline');
        const deadlineTime = new Date(deadline).getTime();
        
        const $timeLeftEL = $timerEL.find('.time-left');

		// 1초마다 무한 반복
        const intervalId = setInterval(() => {
            const now = new Date().getTime();
            const distance = deadlineTime - now;

            // 시간이 남았을 경우
            if (distance > 0) {
                const hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
                const minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
                const seconds = Math.floor((distance % (1000 * 60)) / 1000);
                
                $timeLeftEL.text(
                    `${String(hours).padStart(2, '0')}:${String(minutes).padStart(2, '0')}:${String(seconds).padStart(2, '0')} 남음`
                );

            } else {
				// 타이머 종료
                clearInterval(intervalId);
                $timeLeftEL.text('마감');
            }
        }, 1000);
    });
};
