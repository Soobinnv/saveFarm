(function() {
	const isHidden = el => {
		const styles = window.getComputedStyle(el);
		return styles.display === 'none' || styles.visibility === 'hidden';
	}; 
		
  /**
   * Mobile Menu 
  */
	const mobileNavToggleBtn = document.querySelector('.mobile-nav-toggle');
	function mobileNavToogle() {
		document.querySelectorAll('.vertical-nav > .nav-menu > li.has-sub-menu').forEach(el => {
			el.setAttribute('aria-expanded', 'false');
			if(el.querySelector('ul')) {
				el.querySelector('ul').classList.remove('dropdown-active');
			}
		});
		
		document.querySelector('body').classList.toggle('mobile-nav-active');
	}
  
	mobileNavToggleBtn.addEventListener('click', mobileNavToogle);

	document.querySelector('.menu-closed-icon').addEventListener('click', () => {
		if (document.querySelector('.mobile-nav-active')) {
			mobileNavToogle();
		}
	});
		
  /*
	document.querySelectorAll('.vertical-nav > .nav-menu .menu-link').forEach(navmenu => {
		navmenu.addEventListener('click', () => {
			if (document.querySelector('.mobile-nav-active')) {
				mobileNavToogle();
			}
		});
	});
  */  
  
	document.querySelectorAll('.vertical-nav > .nav-menu > li > .menu-link').forEach(menu => {
		menu.addEventListener('click', function(e) {
		
			if(isHidden(mobileNavToggleBtn)) {
				document.querySelector('body').classList.remove('mobile-nav-active');
			}

			// const isMobile = document.querySelector('.mobile-nav-active');
			// const navExpand = this.closest('.nav-expand-lg');
			// const hasSubMenu = this.parentNode.classList.contains('has-sub-menu');

			const preEl = this.nextElementSibling || null;
				
			document.querySelectorAll('.vertical-nav > .nav-menu > li').forEach(el => {
				el.classList.remove('active');
          
				const submenu = el.querySelector('ul');
				if(submenu && preEl !== submenu) {
					el.setAttribute('aria-expanded', 'false');
					submenu.classList.remove('dropdown-active');
				}
			});

			this.parentNode.classList.toggle('active');
			if (this.parentNode.classList.contains('has-sub-menu')) {
				const expanded = this.parentNode.getAttribute('aria-expanded') === 'true';
				this.parentNode.setAttribute('aria-expanded', ! expanded);
					
				const submenu = this.nextElementSibling;
				submenu.classList.toggle('dropdown-active');
			}

			e.stopImmediatePropagation();
		});
	});

	// collapsed-menu click
	document.querySelector('.collapsed-menu').onclick = function () {
		// expanded 된 메뉴인 경우 닫기
		document.querySelectorAll('.vertical-nav > .nav-menu > li').forEach(el => {
			const submenu = el.querySelector('ul');
			if(submenu) {
				el.setAttribute('aria-expanded', 'false');
				
				// submenu.style.maxHeight = '0px';
				submenu.classList.remove('dropdown-active');
			}
		});
	  
		document.querySelector('.vertical-nav').classList.toggle('nav-expand-lg');
		document.querySelector('.vertical-nav').classList.toggle('nav-expand-sm');
		
		const expanded = this.parentNode.getAttribute('aria-expanded') === 'true';
		this.parentNode.setAttribute('aria-expanded', ! expanded);
	};
 
  /**
   * Preloader : 로딩중일 때 출력 
   */
	const preloader = document.querySelector('#preloader');
	if (! isHidden(preloader)) {
		window.addEventListener('load', () => {
			preloader.style.display = 'none';
		});
	}
  
  /**
   * Scroll top button
   */
	let scrollTop = document.querySelector('.scroll-top');
	if(scrollTop) {
		function toggleScrollTop() {
			if (scrollTop) {
				window.scrollY > 100 ? scrollTop.classList.add('active') : scrollTop.classList.remove('active');
			}
		}
		
		scrollTop.addEventListener('click', (e) => {
			e.preventDefault();
			window.scrollTo({
				top: 0,
				behavior: 'smooth'
			});
		});
	
		window.addEventListener('load', toggleScrollTop);
		document.addEventListener('scroll', toggleScrollTop);
	}
  
  /**
   * Animation on scroll function and init : AOS 초기화
   */
	function aosInit() {
		AOS.init({
			duration: 600,
			easing: 'ease-in-out',
			once: true,
			mirror: false
		});
	}
	
	window.addEventListener('load', aosInit);
})();

// 메뉴 active
document.addEventListener("DOMContentLoaded", function () {
	const currentPath = window.location.pathname;
	const allLinks = document.querySelectorAll(".nav-menu a.menu-link, .nav-menu a.sub-menu-link");

    function getPathCandidates(path) {
        const parts = path.split("/");
        const candidates = [];
        for (let i = parts.length; i > 1; i--) {
            const subPath = parts.slice(0, i).join("/");
            candidates.push(subPath);
        }
        
        return candidates;
    }
    
    const pathCandidates = getPathCandidates(currentPath);

    let matchedLink = null;
    for (let i = 0; i < pathCandidates.length; i++) {
    	for (let j = 0; j < allLinks.length; j++) {
    		let linkPath = allLinks[j].getAttribute('href');
    		if(i != 0) {
    			let linkCandidates = getPathCandidates(allLinks[j].getAttribute('href'));
    			if(linkCandidates[i]) {
    				linkPath = linkCandidates[i];
    			}
    		}
    		if(linkPath === '#') continue;
    		
    		// if (pathCandidates[i] === linkPath) {
    		if (linkPath.startsWith(pathCandidates[i])) {
    			matchedLink = allLinks[j];
                break;
    		}
    	}
    	
    	if (matchedLink) break;
    	
    }
    
    // 가장 가까운 링크에 active 클래스 적용
    if (matchedLink) {
        const  li = matchedLink.closest("li");
		const parentMenu = matchedLink.closest("li.has-sub-menu");
        
        if (parentMenu) {
        	parentMenu.setAttribute("aria-expanded", "true");
        	matchedLink.parentElement.classList.add("active");
        	matchedLink.closest("ul").classList.add('dropdown-active');
        } else {
        	 li.classList.add("active");
        }
    }
});
