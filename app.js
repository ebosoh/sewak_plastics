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
});
