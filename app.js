/* Navigation Logic */
document.addEventListener('DOMContentLoaded', () => {
    const hamburger = document.querySelector('.hamburger');
    const navLinks = document.querySelector('.nav-links');

    if (hamburger && navLinks) {
        hamburger.addEventListener('click', () => {
            navLinks.classList.toggle('active');
            hamburger.classList.toggle('is-active');
        });
    }

    // Active Link Highlighting
    const currentPage = window.location.pathname.split('/').pop() || 'index.html';
    const menuLinks = document.querySelectorAll('.nav-links a');

    menuLinks.forEach(link => {
        const linkPage = link.getAttribute('href');
        if (linkPage === currentPage || (currentPage === '' && linkPage === 'index.html')) {
            link.classList.add('active');
        }
    });

    // Auto-greeting for WhatsApp (Optional enhancement hook)
    const waBtn = document.querySelector('.floating-whatsapp');
    if (waBtn) {
        waBtn.addEventListener('mouseenter', () => {
            // Potential future tooltip animation
        });
    }

    // Hero Carousel Logic
    let slideIndex = 1;
    const slides = document.querySelectorAll('.carousel-slide');
    const dots = document.querySelectorAll('.dot');
    let slideInterval;

    function showSlides(n) {
        if (slides.length === 0) return;

        if (n > slides.length) { slideIndex = 1 }
        if (n < 1) { slideIndex = slides.length }

        // Hide all slides
        slides.forEach(slide => slide.classList.remove('active'));
        dots.forEach(dot => dot.classList.remove('active'));

        // Show active slide
        if (slides[slideIndex - 1]) {
            slides[slideIndex - 1].classList.add('active');
        }
        if (dots[slideIndex - 1]) {
            dots[slideIndex - 1].classList.add('active');
        }
    }

    window.currentSlide = function (n) {
        clearInterval(slideInterval); // Stop auto-scroll on manual click
        showSlides(slideIndex = n);
        startAutoSlide(); // Restart auto-scroll
    }

    function startAutoSlide() {
        if (slides.length === 0) return;
        clearInterval(slideInterval);
        slideInterval = setInterval(() => {
            showSlides(slideIndex += 1);
        }, 5000); // Change image every 5 seconds
    }

    // Initialize Carousel
    if (slides.length > 0) {
        showSlides(slideIndex);
        startAutoSlide();
    }
});
