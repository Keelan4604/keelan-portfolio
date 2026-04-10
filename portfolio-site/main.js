/* =========================================================
   Keelan O'Doherty — Portfolio Site
   Main JavaScript: Animations, Effects, Interactions
   ========================================================= */

document.addEventListener('DOMContentLoaded', () => {
  // Register GSAP ScrollTrigger
  gsap.registerPlugin(ScrollTrigger);

  /* ----- ANIMATED GRID CANVAS ----- */
  initGridCanvas();

  /* ----- STAR PARTICLES ----- */
  initStarsCanvas();

  /* ----- HERO ENTRANCE ANIMATION ----- */
  initHeroAnimation();

  /* ----- TYPING EFFECT ----- */
  initTypingEffect();

  /* ----- SCROLL REVEAL ----- */
  initScrollReveal();

  /* ----- NUMBER TICKERS ----- */
  initNumberTickers();

  /* ----- CURSOR GLOW ----- */
  initCursorGlow();

  /* ----- CARD MOUSE TRACKING ----- */
  initCardMouseTracking();

  /* ----- NAVIGATION ----- */
  initNavigation();

  /* ----- MOBILE MENU ----- */
  initMobileMenu();

  /* ----- SMOOTH SCROLL ----- */
  initSmoothScroll();

  /* ----- PARALLAX ORBS ----- */
  initParallaxOrbs();
});

/* =============================
   ANIMATED GRID CANVAS
   ============================= */
function initGridCanvas() {
  const canvas = document.getElementById('grid-canvas');
  if (!canvas) return;

  const ctx = canvas.getContext('2d');
  let width, height, cols, rows;
  const cellSize = 60;
  let mouse = { x: -1000, y: -1000 };
  let frame = 0;

  function resize() {
    width = canvas.width = canvas.offsetWidth;
    height = canvas.height = canvas.offsetHeight;
    cols = Math.ceil(width / cellSize) + 1;
    rows = Math.ceil(height / cellSize) + 1;
  }

  resize();
  window.addEventListener('resize', resize);

  canvas.parentElement.addEventListener('mousemove', (e) => {
    const rect = canvas.getBoundingClientRect();
    mouse.x = e.clientX - rect.left;
    mouse.y = e.clientY - rect.top;
  });

  canvas.parentElement.addEventListener('mouseleave', () => {
    mouse.x = -1000;
    mouse.y = -1000;
  });

  function draw() {
    ctx.clearRect(0, 0, width, height);
    frame++;

    for (let i = 0; i < cols; i++) {
      for (let j = 0; j < rows; j++) {
        const x = i * cellSize;
        const y = j * cellSize;

        // Distance from mouse
        const dx = mouse.x - x;
        const dy = mouse.y - y;
        const dist = Math.sqrt(dx * dx + dy * dy);
        const maxDist = 200;
        const influence = Math.max(0, 1 - dist / maxDist);

        // Base opacity with subtle animation
        const wave = Math.sin(frame * 0.01 + i * 0.3 + j * 0.3) * 0.02;
        const baseOpacity = 0.04 + wave;
        const opacity = baseOpacity + influence * 0.2;

        // Draw intersection dot
        ctx.beginPath();
        ctx.arc(x, y, 1 + influence * 2, 0, Math.PI * 2);
        ctx.fillStyle = `rgba(99, 102, 241, ${opacity})`;
        ctx.fill();

        // Draw grid lines with mouse proximity glow
        if (influence > 0) {
          // Horizontal line
          if (i < cols - 1) {
            ctx.beginPath();
            ctx.moveTo(x, y);
            ctx.lineTo(x + cellSize, y);
            ctx.strokeStyle = `rgba(99, 102, 241, ${influence * 0.1})`;
            ctx.lineWidth = 0.5;
            ctx.stroke();
          }
          // Vertical line
          if (j < rows - 1) {
            ctx.beginPath();
            ctx.moveTo(x, y);
            ctx.lineTo(x, y + cellSize);
            ctx.strokeStyle = `rgba(99, 102, 241, ${influence * 0.1})`;
            ctx.lineWidth = 0.5;
            ctx.stroke();
          }
        }
      }
    }

    requestAnimationFrame(draw);
  }

  draw();
}

/* =============================
   STAR PARTICLES CANVAS
   ============================= */
function initStarsCanvas() {
  const canvas = document.getElementById('stars-canvas');
  if (!canvas) return;

  const ctx = canvas.getContext('2d');
  let width, height;
  const stars = [];
  const numStars = 80;

  function resize() {
    width = canvas.width = canvas.offsetWidth;
    height = canvas.height = canvas.offsetHeight;
  }

  resize();
  window.addEventListener('resize', resize);

  // Create stars
  for (let i = 0; i < numStars; i++) {
    stars.push({
      x: Math.random() * width,
      y: Math.random() * height,
      size: Math.random() * 1.5 + 0.5,
      speed: Math.random() * 0.3 + 0.05,
      opacity: Math.random() * 0.5 + 0.2,
      pulse: Math.random() * Math.PI * 2,
      pulseSpeed: Math.random() * 0.02 + 0.005,
    });
  }

  // Shooting stars
  let shootingStars = [];

  function spawnShootingStar() {
    if (shootingStars.length < 2 && Math.random() < 0.005) {
      shootingStars.push({
        x: Math.random() * width * 0.8,
        y: Math.random() * height * 0.4,
        length: Math.random() * 80 + 40,
        speed: Math.random() * 8 + 6,
        angle: (Math.PI / 6) + Math.random() * (Math.PI / 8),
        opacity: 1,
        life: 1,
      });
    }
  }

  function draw() {
    ctx.clearRect(0, 0, width, height);

    // Draw stars
    stars.forEach((star) => {
      star.pulse += star.pulseSpeed;
      const flickerOpacity = star.opacity + Math.sin(star.pulse) * 0.15;

      ctx.beginPath();
      ctx.arc(star.x, star.y, star.size, 0, Math.PI * 2);
      ctx.fillStyle = `rgba(200, 210, 255, ${Math.max(0, flickerOpacity)})`;
      ctx.fill();

      // Subtle glow on larger stars
      if (star.size > 1.2) {
        ctx.beginPath();
        ctx.arc(star.x, star.y, star.size * 3, 0, Math.PI * 2);
        ctx.fillStyle = `rgba(99, 102, 241, ${flickerOpacity * 0.1})`;
        ctx.fill();
      }

      // Slow drift
      star.y += star.speed;
      if (star.y > height + 5) {
        star.y = -5;
        star.x = Math.random() * width;
      }
    });

    // Shooting stars
    spawnShootingStar();
    shootingStars = shootingStars.filter((s) => s.life > 0);
    shootingStars.forEach((s) => {
      const dx = Math.cos(s.angle) * s.speed;
      const dy = Math.sin(s.angle) * s.speed;
      s.x += dx;
      s.y += dy;
      s.life -= 0.015;
      s.opacity = s.life;

      const tailX = s.x - Math.cos(s.angle) * s.length;
      const tailY = s.y - Math.sin(s.angle) * s.length;

      const gradient = ctx.createLinearGradient(s.x, s.y, tailX, tailY);
      gradient.addColorStop(0, `rgba(200, 210, 255, ${s.opacity * 0.8})`);
      gradient.addColorStop(1, 'rgba(200, 210, 255, 0)');

      ctx.beginPath();
      ctx.moveTo(s.x, s.y);
      ctx.lineTo(tailX, tailY);
      ctx.strokeStyle = gradient;
      ctx.lineWidth = 1.5;
      ctx.stroke();
    });

    requestAnimationFrame(draw);
  }

  draw();
}

/* =============================
   HERO ENTRANCE ANIMATION
   ============================= */
function initHeroAnimation() {
  const tl = gsap.timeline({ defaults: { ease: 'power3.out' } });

  tl.to('.hero-element', {
    opacity: 1,
    y: 0,
    duration: 1,
    stagger: 0.15,
    delay: 0.3,
  });
}

/* =============================
   TYPING EFFECT
   ============================= */
function initTypingEffect() {
  const el = document.getElementById('typed-text');
  if (!el) return;

  const phrases = [
    'aerospace systems',
    'computational fluid dynamics',
    'structural analysis',
    'orbital mechanics',
    'propulsion systems',
    'flight dynamics',
    'software tools',
  ];

  let phraseIdx = 0;
  let charIdx = 0;
  let isDeleting = false;
  let timeout;

  function type() {
    const currentPhrase = phrases[phraseIdx];

    if (!isDeleting) {
      el.textContent = currentPhrase.substring(0, charIdx + 1);
      charIdx++;

      if (charIdx === currentPhrase.length) {
        isDeleting = true;
        timeout = setTimeout(type, 2000); // Pause at end
        return;
      }
      timeout = setTimeout(type, 60 + Math.random() * 40);
    } else {
      el.textContent = currentPhrase.substring(0, charIdx - 1);
      charIdx--;

      if (charIdx === 0) {
        isDeleting = false;
        phraseIdx = (phraseIdx + 1) % phrases.length;
        timeout = setTimeout(type, 400);
        return;
      }
      timeout = setTimeout(type, 30);
    }
  }

  // Start after hero animation
  setTimeout(type, 1800);
}

/* =============================
   SCROLL REVEAL (Intersection Observer)
   ============================= */
function initScrollReveal() {
  const elements = document.querySelectorAll('.reveal-up');

  const observer = new IntersectionObserver(
    (entries) => {
      entries.forEach((entry) => {
        if (entry.isIntersecting) {
          entry.target.classList.add('revealed');
          observer.unobserve(entry.target);
        }
      });
    },
    { threshold: 0.1, rootMargin: '0px 0px -50px 0px' }
  );

  elements.forEach((el) => observer.observe(el));
}

/* =============================
   NUMBER TICKERS
   ============================= */
function initNumberTickers() {
  const tickers = document.querySelectorAll('.number-ticker');

  const observer = new IntersectionObserver(
    (entries) => {
      entries.forEach((entry) => {
        if (entry.isIntersecting) {
          const el = entry.target;
          const target = parseInt(el.dataset.target, 10);
          animateNumber(el, 0, target, 1500);
          observer.unobserve(el);
        }
      });
    },
    { threshold: 0.5 }
  );

  tickers.forEach((el) => observer.observe(el));
}

function animateNumber(el, start, end, duration) {
  const startTime = performance.now();

  function update(currentTime) {
    const elapsed = currentTime - startTime;
    const progress = Math.min(elapsed / duration, 1);

    // Ease out cubic
    const eased = 1 - Math.pow(1 - progress, 3);
    const current = Math.round(start + (end - start) * eased);

    el.textContent = current;

    if (progress < 1) {
      requestAnimationFrame(update);
    }
  }

  requestAnimationFrame(update);
}

/* =============================
   CURSOR GLOW
   ============================= */
function initCursorGlow() {
  const glow = document.getElementById('cursor-glow');
  if (!glow || window.matchMedia('(pointer: coarse)').matches) return;

  let mouseX = 0, mouseY = 0;
  let glowX = 0, glowY = 0;

  document.addEventListener('mousemove', (e) => {
    mouseX = e.clientX;
    mouseY = e.clientY;
    glow.style.opacity = '1';
  });

  document.addEventListener('mouseleave', () => {
    glow.style.opacity = '0';
  });

  function animate() {
    // Smooth follow
    glowX += (mouseX - glowX) * 0.1;
    glowY += (mouseY - glowY) * 0.1;

    glow.style.left = glowX - 300 + 'px';
    glow.style.top = glowY - 300 + 'px';

    requestAnimationFrame(animate);
  }

  animate();
}

/* =============================
   CARD MOUSE TRACKING (magic card effect)
   ============================= */
function initCardMouseTracking() {
  const cards = document.querySelectorAll('.skill-card, .project-card, .stat-card');

  cards.forEach((card) => {
    card.addEventListener('mousemove', (e) => {
      const rect = card.getBoundingClientRect();
      const x = ((e.clientX - rect.left) / rect.width) * 100;
      const y = ((e.clientY - rect.top) / rect.height) * 100;
      card.style.setProperty('--mouse-x', x + '%');
      card.style.setProperty('--mouse-y', y + '%');
    });
  });
}

/* =============================
   NAVIGATION (scroll effects)
   ============================= */
function initNavigation() {
  const nav = document.getElementById('nav');
  let lastScroll = 0;

  window.addEventListener('scroll', () => {
    const currentScroll = window.pageYOffset;

    if (currentScroll > 50) {
      nav.classList.add('nav-scrolled');
    } else {
      nav.classList.remove('nav-scrolled');
    }

    lastScroll = currentScroll;
  });

  // Active section highlighting
  const sections = document.querySelectorAll('section[id]');
  const navLinks = document.querySelectorAll('.nav-link');

  const sectionObserver = new IntersectionObserver(
    (entries) => {
      entries.forEach((entry) => {
        if (entry.isIntersecting) {
          const id = entry.target.getAttribute('id');
          navLinks.forEach((link) => {
            link.classList.toggle(
              'text-white',
              link.getAttribute('href') === '#' + id
            );
          });
        }
      });
    },
    { threshold: 0.3, rootMargin: '-80px 0px -50% 0px' }
  );

  sections.forEach((section) => sectionObserver.observe(section));
}

/* =============================
   MOBILE MENU
   ============================= */
function initMobileMenu() {
  const btn = document.getElementById('mobile-menu-btn');
  const menu = document.getElementById('mobile-menu');
  const bar1 = document.getElementById('bar1');
  const bar2 = document.getElementById('bar2');
  const bar3 = document.getElementById('bar3');
  let isOpen = false;

  if (!btn || !menu) return;

  btn.addEventListener('click', () => {
    isOpen = !isOpen;

    if (isOpen) {
      menu.style.maxHeight = '300px';
      bar1.style.transform = 'rotate(45deg) translate(4px, 4px)';
      bar2.style.opacity = '0';
      bar3.style.transform = 'rotate(-45deg) translate(4px, -4px)';
      bar3.style.width = '1.5rem';
    } else {
      menu.style.maxHeight = '0';
      bar1.style.transform = '';
      bar2.style.opacity = '1';
      bar3.style.transform = '';
      bar3.style.width = '1rem';
    }
  });

  // Close on link click
  menu.querySelectorAll('a').forEach((link) => {
    link.addEventListener('click', () => {
      isOpen = false;
      menu.style.maxHeight = '0';
      bar1.style.transform = '';
      bar2.style.opacity = '1';
      bar3.style.transform = '';
      bar3.style.width = '1rem';
    });
  });
}

/* =============================
   SMOOTH SCROLL
   ============================= */
function initSmoothScroll() {
  document.querySelectorAll('a[href^="#"]').forEach((anchor) => {
    anchor.addEventListener('click', function (e) {
      e.preventDefault();
      const target = document.querySelector(this.getAttribute('href'));
      if (target) {
        const offset = 80;
        const position = target.getBoundingClientRect().top + window.pageYOffset - offset;
        window.scrollTo({ top: position, behavior: 'smooth' });
      }
    });
  });
}

/* =============================
   PARALLAX ORBS ON SCROLL
   ============================= */
function initParallaxOrbs() {
  const orbs = document.querySelectorAll('.orb');

  window.addEventListener('scroll', () => {
    const scrollY = window.pageYOffset;
    orbs.forEach((orb, i) => {
      const speed = 0.05 + i * 0.02;
      orb.style.transform = `translateY(${scrollY * speed}px)`;
    });
  });

  // Also add GSAP scroll-driven animations for extra sections
  gsap.utils.toArray('.skill-card').forEach((card, i) => {
    gsap.fromTo(
      card,
      { y: 30, opacity: 0 },
      {
        y: 0,
        opacity: 1,
        duration: 0.8,
        delay: i * 0.1,
        scrollTrigger: {
          trigger: card,
          start: 'top 85%',
          toggleActions: 'play none none none',
        },
      }
    );
  });

  gsap.utils.toArray('.project-card').forEach((card, i) => {
    gsap.fromTo(
      card,
      { y: 40, opacity: 0 },
      {
        y: 0,
        opacity: 1,
        duration: 0.9,
        delay: i * 0.15,
        scrollTrigger: {
          trigger: card,
          start: 'top 85%',
          toggleActions: 'play none none none',
        },
      }
    );
  });

  gsap.utils.toArray('.timeline-item').forEach((item, i) => {
    gsap.fromTo(
      item,
      { x: i % 2 === 0 ? -30 : 30, opacity: 0 },
      {
        x: 0,
        opacity: 1,
        duration: 0.8,
        scrollTrigger: {
          trigger: item,
          start: 'top 85%',
          toggleActions: 'play none none none',
        },
      }
    );
  });
}
