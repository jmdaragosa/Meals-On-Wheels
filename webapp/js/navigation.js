function toggleMenu() {
    const navLinks = document.querySelector('.nav-links');
    if (navLinks) {
        navLinks.classList.toggle('show');
    }
}

let lastScrollY = 0;
const header = document.getElementById('site-header');

window.addEventListener('scroll', () => {
    const currentScrollY = window.scrollY;

    if (currentScrollY > lastScrollY) {
        header.classList.add('hide');
    } else {
        header.classList.remove('hide');
    }

    lastScrollY = currentScrollY;
    console.log("Scroll Y:", currentScrollY, "Header Class:", header.classList); //For debugging
});

document.addEventListener("DOMContentLoaded", function() {
    const urlParams = new URLSearchParams(window.location.search);
    const selectedTab = urlParams.get('tab');
    
    if (selectedTab) {
        // Hide all sections and remove active class from tabs
        document.querySelectorAll('.content-section').forEach(section => {
            section.classList.add('hidden');
        });
        document.querySelectorAll('.tab').forEach(tab => {
            tab.classList.remove('active');
        });

        // Show the requested tab and mark it active
        const targetSection = document.getElementById(selectedTab);
        if (targetSection) {
            targetSection.classList.remove('hidden');
            const activeTab = document.querySelector(`.tab[data-tab="${selectedTab}"]`);
            if (activeTab) {
                activeTab.classList.add('active');
            }
        }
    }
});