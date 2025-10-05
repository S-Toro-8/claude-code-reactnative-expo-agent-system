// ============================================================================
// CLAUDE CODE DOCUMENTATION - ADVANCED INTERACTIVITY & ENHANCEMENT SYSTEM
// ============================================================================
// Version: 1.0.0
// Features: Advanced Search, Keyboard Nav, Animations, Syntax Highlighting,
//           Progress Bar, Count-up Stats, Scroll Effects, Accessibility
// ============================================================================

// ============================================================================
// UTILITIES & HELPERS
// ============================================================================

// Debounce function for performance optimization
function debounce(func, wait) {
    let timeout;
    return function executedFunction(...args) {
        const later = () => {
            clearTimeout(timeout);
            func(...args);
        };
        clearTimeout(timeout);
        timeout = setTimeout(later, wait);
    };
}

// Check if user prefers reduced motion
const prefersReducedMotion = window.matchMedia('(prefers-reduced-motion: reduce)').matches;

// Easing functions for smooth animations
const easing = {
    easeOutQuad: t => t * (2 - t),
    easeInOutCubic: t => t < 0.5 ? 4 * t * t * t : (t - 1) * (2 * t - 2) * (2 * t - 2) + 1,
    easeOutExpo: t => t === 1 ? 1 : 1 - Math.pow(2, -10 * t)
};

// ============================================================================
// READING PROGRESS BAR
// ============================================================================

function createProgressBar() {
    const progressBar = document.createElement('div');
    progressBar.id = 'reading-progress';
    progressBar.style.cssText = `
        position: fixed;
        top: 0;
        left: 0;
        height: 3px;
        background: linear-gradient(90deg, var(--primary), var(--secondary));
        width: 0%;
        z-index: 9999;
        transition: width 0.1s ease;
    `;
    document.body.appendChild(progressBar);

    const updateProgress = () => {
        const windowHeight = window.innerHeight;
        const documentHeight = document.documentElement.scrollHeight - windowHeight;
        const scrolled = window.scrollY;
        const progress = (scrolled / documentHeight) * 100;
        progressBar.style.width = `${Math.min(progress, 100)}%`;
    };

    window.addEventListener('scroll', debounce(updateProgress, 10));
    updateProgress();
}

// ============================================================================
// ADVANCED SEARCH SYSTEM WITH KEYBOARD NAVIGATION
// ============================================================================

function createAdvancedSearch() {
    // Create search container in agents section
    const agentsSection = document.getElementById('agents');
    if (!agentsSection) return;

    const searchContainer = document.createElement('div');
    searchContainer.className = 'search-box';
    searchContainer.style.marginTop = '2rem';

    searchContainer.innerHTML = `
        <span class="search-icon">🔍</span>
        <input type="text" id="agent-search" class="search-input"
               placeholder="Search agents... (try: accessibility, performance, security)"
               autocomplete="off">
        <div id="search-results" style="display: none; position: absolute; top: 100%; left: 0; right: 0;
             background: var(--bg-secondary); border: 1px solid var(--border-primary);
             border-radius: 0.5rem; margin-top: 0.5rem; max-height: 400px; overflow-y: auto; z-index: 100;">
        </div>
    `;

    const agentsTitle = agentsSection.querySelector('h2');
    agentsTitle.insertAdjacentElement('afterend', searchContainer);

    const searchInput = document.getElementById('agent-search');
    const searchResults = document.getElementById('search-results');
    const agentCards = document.querySelectorAll('.agent-card');

    let selectedIndex = -1;
    let searchableItems = [];

    // Build searchable index
    agentCards.forEach(card => {
        const title = card.querySelector('h3').textContent;
        const description = card.querySelector('p').textContent;
        const tags = Array.from(card.querySelectorAll('.tag')).map(t => t.textContent).join(' ');

        searchableItems.push({
            element: card,
            title,
            description,
            tags,
            searchText: `${title} ${description} ${tags}`.toLowerCase()
        });
    });

    // Debounced search function
    const performSearch = debounce((query) => {
        if (!query.trim()) {
            searchResults.style.display = 'none';
            agentCards.forEach(card => card.style.display = '');
            selectedIndex = -1;
            return;
        }

        const searchTerm = query.toLowerCase();
        const matches = searchableItems.filter(item =>
            item.searchText.includes(searchTerm)
        );

        // Show/hide cards
        agentCards.forEach(card => card.style.display = 'none');
        matches.forEach(match => match.element.style.display = '');

        // Show search results dropdown
        if (matches.length > 0) {
            searchResults.innerHTML = matches.map((match, index) => `
                <div class="search-result-item" data-index="${index}" style="
                    padding: 1rem;
                    cursor: pointer;
                    border-bottom: 1px solid var(--border-primary);
                    transition: background 0.2s;
                " onmouseover="this.style.background='var(--bg-tertiary)'"
                   onmouseout="this.style.background='transparent'">
                    <div style="font-weight: 600; color: var(--primary);">${highlightMatch(match.title, searchTerm)}</div>
                    <div style="font-size: 0.875rem; color: var(--text-secondary); margin-top: 0.25rem;">
                        ${highlightMatch(match.description.substring(0, 100) + '...', searchTerm)}
                    </div>
                </div>
            `).join('');
            searchResults.style.display = 'block';
        } else {
            searchResults.innerHTML = `
                <div style="padding: 1rem; text-align: center; color: var(--text-tertiary);">
                    No agents found for "${query}"
                </div>
            `;
            searchResults.style.display = 'block';
        }
    }, 300);

    // Highlight matching text
    function highlightMatch(text, query) {
        const regex = new RegExp(`(${query})`, 'gi');
        return text.replace(regex, '<mark style="background: var(--primary); color: var(--bg-primary); padding: 0 0.25rem; border-radius: 0.25rem;">$1</mark>');
    }

    // Keyboard navigation
    searchInput.addEventListener('keydown', (e) => {
        const items = searchResults.querySelectorAll('.search-result-item');

        if (e.key === 'ArrowDown') {
            e.preventDefault();
            selectedIndex = Math.min(selectedIndex + 1, items.length - 1);
            updateSelection(items);
        } else if (e.key === 'ArrowUp') {
            e.preventDefault();
            selectedIndex = Math.max(selectedIndex - 1, -1);
            updateSelection(items);
        } else if (e.key === 'Enter' && selectedIndex >= 0) {
            e.preventDefault();
            const match = searchableItems.filter(item =>
                item.searchText.includes(searchInput.value.toLowerCase())
            )[selectedIndex];
            if (match) {
                match.element.scrollIntoView({ behavior: 'smooth', block: 'center' });
                match.element.querySelector('details')?.setAttribute('open', '');
                searchResults.style.display = 'none';
            }
        } else if (e.key === 'Escape') {
            searchResults.style.display = 'none';
            selectedIndex = -1;
        }
    });

    function updateSelection(items) {
        items.forEach((item, index) => {
            if (index === selectedIndex) {
                item.style.background = 'var(--bg-tertiary)';
                item.scrollIntoView({ block: 'nearest' });
            } else {
                item.style.background = 'transparent';
            }
        });
    }

    searchInput.addEventListener('input', (e) => performSearch(e.target.value));

    // Click outside to close
    document.addEventListener('click', (e) => {
        if (!searchContainer.contains(e.target)) {
            searchResults.style.display = 'none';
        }
    });
}

// ============================================================================
// EXPANDABLE AGENT CARDS
// ============================================================================

function initializeExpandableCards() {
    const agentCards = document.querySelectorAll('.agent-card');
    let currentlyExpanded = null;

    agentCards.forEach(card => {
        const details = card.querySelector('details');
        if (!details) return;

        const summary = details.querySelector('summary');

        // Add expand icon
        const icon = document.createElement('span');
        icon.textContent = ' ▼';
        icon.style.cssText = `
            display: inline-block;
            transition: transform 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            font-size: 0.75rem;
            margin-left: 0.5rem;
        `;
        summary.appendChild(icon);

        details.addEventListener('toggle', () => {
            if (!prefersReducedMotion) {
                if (details.open) {
                    // Close previously expanded card
                    if (currentlyExpanded && currentlyExpanded !== details) {
                        currentlyExpanded.removeAttribute('open');
                    }
                    currentlyExpanded = details;

                    // Rotate icon
                    icon.style.transform = 'rotate(180deg)';

                    // Smooth expand animation
                    const content = details.querySelector('div');
                    if (content) {
                        content.style.animation = 'slideDown 0.3s ease-out';
                    }

                    // Scroll card into view
                    setTimeout(() => {
                        card.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
                    }, 100);
                } else {
                    icon.style.transform = 'rotate(0deg)';
                }
            }
        });
    });

    // Add CSS animation
    const style = document.createElement('style');
    style.textContent = `
        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    `;
    document.head.appendChild(style);
}

// ============================================================================
// SYNTAX HIGHLIGHTING (Inline - Lightweight)
// ============================================================================

function initializeSyntaxHighlighting() {
    // Lightweight syntax highlighter (inline)
    const codeBlocks = document.querySelectorAll('pre code');

    codeBlocks.forEach(block => {
        const code = block.textContent;

        // Simple syntax highlighting for common patterns
        let highlighted = code
            // Comments
            .replace(/(#.*$)/gm, '<span style="color: #6A9955;">$1</span>')
            // Strings
            .replace(/(['"])(.+?)\1/g, '<span style="color: #CE9178;">$1$2$1</span>')
            // Keywords (bash, powershell)
            .replace(/\b(cd|ls|cat|npm|npx|git|Set-ExecutionPolicy|function|if|else|for|while|return)\b/g,
                     '<span style="color: #569CD6;">$1</span>')
            // Commands/functions
            .replace(/\b([a-z_]+)(?=\()/g, '<span style="color: #DCDCAA;">$1</span>')
            // Variables
            .replace(/\$\w+/g, '<span style="color: #9CDCFE;">$&</span>')
            // Flags
            .replace(/--?\w+/g, '<span style="color: #C586C0;">$&</span>');

        block.innerHTML = highlighted;

        // Add language badge
        const pre = block.parentElement;
        const badge = document.createElement('div');
        badge.textContent = detectLanguage(code);
        badge.style.cssText = `
            position: absolute;
            top: 0.5rem;
            left: 0.5rem;
            background: var(--bg-tertiary);
            color: var(--text-tertiary);
            padding: 0.25rem 0.5rem;
            border-radius: 0.25rem;
            font-size: 0.75rem;
            font-weight: 600;
            text-transform: uppercase;
        `;
        pre.appendChild(badge);
    });
}

function detectLanguage(code) {
    if (code.includes('npm') || code.includes('npx')) return 'bash';
    if (code.includes('Set-ExecutionPolicy')) return 'powershell';
    if (code.includes('import') || code.includes('export')) return 'javascript';
    if (code.includes('---\nname:')) return 'yaml';
    return 'code';
}

// ============================================================================
// ANIMATED STATISTICS (Count-up Effect)
// ============================================================================

function animateStatistics() {
    const stats = document.querySelectorAll('.stat-value');
    const observerOptions = {
        threshold: 0.5,
        rootMargin: '0px'
    };

    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting && !entry.target.dataset.animated) {
                entry.target.dataset.animated = 'true';
                animateValue(entry.target);
            }
        });
    }, observerOptions);

    stats.forEach(stat => observer.observe(stat));
}

function animateValue(element) {
    const text = element.textContent;
    const isPercentage = text.includes('%');
    const targetValue = parseInt(text.replace(/[^\d]/g, ''));
    const duration = 2000;
    const startTime = performance.now();

    function update(currentTime) {
        const elapsed = currentTime - startTime;
        const progress = Math.min(elapsed / duration, 1);
        const easedProgress = easing.easeOutExpo(progress);
        const currentValue = Math.floor(easedProgress * targetValue);

        element.textContent = isPercentage ? `${currentValue}%` : currentValue;

        if (progress < 1) {
            requestAnimationFrame(update);
        } else {
            element.textContent = text; // Restore original text
        }
    }

    if (!prefersReducedMotion) {
        requestAnimationFrame(update);
    }
}

// ============================================================================
// SCROLL ANIMATIONS (Intersection Observer)
// ============================================================================

function initializeScrollAnimations() {
    if (prefersReducedMotion) return;

    const style = document.createElement('style');
    style.textContent = `
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .animate-on-scroll {
            opacity: 0;
        }

        .animate-on-scroll.visible {
            animation: fadeInUp 0.6s ease-out forwards;
        }
    `;
    document.head.appendChild(style);

    const observerOptions = {
        threshold: 0.1,
        rootMargin: '0px 0px -100px 0px'
    };

    const observer = new IntersectionObserver((entries) => {
        entries.forEach((entry, index) => {
            if (entry.isIntersecting) {
                // Stagger animation delay
                setTimeout(() => {
                    entry.target.classList.add('visible');
                }, index * 100);
                observer.unobserve(entry.target);
            }
        });
    }, observerOptions);

    // Observe cards
    document.querySelectorAll('.card, .agent-card').forEach(card => {
        card.classList.add('animate-on-scroll');
        observer.observe(card);
    });
}

// ============================================================================
// PARALLAX EFFECT ON HERO
// ============================================================================

function initializeParallax() {
    if (prefersReducedMotion) return;

    const hero = document.getElementById('hero');
    if (!hero) return;

    const handleScroll = () => {
        const scrolled = window.scrollY;
        const parallaxSpeed = 0.5;

        requestAnimationFrame(() => {
            hero.style.transform = `translateY(${scrolled * parallaxSpeed}px)`;
            hero.style.opacity = 1 - (scrolled / 600);
        });
    };

    window.addEventListener('scroll', debounce(handleScroll, 10));
}

// ============================================================================
// NAVIGATION & ACTIVE STATE
// ============================================================================

const sections = document.querySelectorAll('.section');
const navLinks = document.querySelectorAll('.nav-links a');

function updateActiveLink() {
    const scrollPos = window.scrollY + 100;

    sections.forEach(section => {
        const sectionTop = section.offsetTop;
        const sectionHeight = section.offsetHeight;
        const sectionId = section.getAttribute('id');

        if (scrollPos >= sectionTop && scrollPos < sectionTop + sectionHeight) {
            navLinks.forEach(link => {
                link.classList.remove('active');
                if (link.getAttribute('href') === `#${sectionId}`) {
                    link.classList.add('active');
                }
            });
        }
    });
}

window.addEventListener('scroll', updateActiveLink);

// Mobile nav toggle
const navToggle = document.querySelector('.nav-toggle');
const navLinksContainer = document.querySelector('.nav-links');

if (navToggle && navLinksContainer) {
    navToggle.addEventListener('click', () => {
        navLinksContainer.classList.toggle('active');
    });

    // Close mobile nav on link click
    navLinks.forEach(link => {
        link.addEventListener('click', () => {
            navLinksContainer.classList.remove('active');
        });
    });
}

// ============================================================================
// ENHANCED SEARCH FUNCTIONALITY (Troubleshooting & FAQ)
// ============================================================================

const troubleshootingSearch = document.getElementById('troubleshooting-search');
const troubleshootingList = document.getElementById('troubleshooting-list');

if (troubleshootingSearch) {
    troubleshootingSearch.addEventListener('input', debounce((e) => {
        const searchTerm = e.target.value.toLowerCase();
        const details = troubleshootingList.querySelectorAll('details');

        details.forEach(detail => {
            const text = detail.textContent.toLowerCase();
            if (text.includes(searchTerm)) {
                detail.style.display = 'block';
                // Auto-expand if searching
                if (searchTerm.length > 2) {
                    detail.setAttribute('open', '');
                }
            } else {
                detail.style.display = 'none';
            }
        });
    }, 300));
}

const faqSearch = document.getElementById('faq-search');
const faqList = document.getElementById('faq-list');

if (faqSearch) {
    faqSearch.addEventListener('input', debounce((e) => {
        const searchTerm = e.target.value.toLowerCase();
        const details = faqList.querySelectorAll('details');

        details.forEach(detail => {
            const text = detail.textContent.toLowerCase();
            if (text.includes(searchTerm)) {
                detail.style.display = 'block';
                if (searchTerm.length > 2) {
                    detail.setAttribute('open', '');
                }
            } else {
                detail.style.display = 'none';
            }
        });
    }, 300));
}

// ============================================================================
// COPY CODE BUTTON WITH ENHANCED FEEDBACK
// ============================================================================

document.querySelectorAll('pre').forEach(pre => {
    const button = document.createElement('button');
    button.className = 'copy-button';
    button.textContent = 'Copy';
    button.addEventListener('click', () => {
        const code = pre.querySelector('code').textContent;
        navigator.clipboard.writeText(code).then(() => {
            button.textContent = 'Copied!';
            button.style.background = 'var(--success)';
            setTimeout(() => {
                button.textContent = 'Copy';
                button.style.background = '';
            }, 2000);
        }).catch(err => {
            button.textContent = 'Failed';
            setTimeout(() => {
                button.textContent = 'Copy';
            }, 2000);
        });
    });
    pre.style.position = 'relative';
    pre.appendChild(button);
});

// ============================================================================
// READING TIME ESTIMATOR
// ============================================================================

function addReadingTime() {
    const sections = document.querySelectorAll('.section');
    const wordsPerMinute = 200;

    sections.forEach(section => {
        const text = section.textContent;
        const wordCount = text.trim().split(/\s+/).length;
        const readingTime = Math.ceil(wordCount / wordsPerMinute);

        const heading = section.querySelector('h2');
        if (heading && readingTime > 1) {
            const badge = document.createElement('span');
            badge.textContent = `${readingTime} min read`;
            badge.style.cssText = `
                display: inline-block;
                margin-left: 1rem;
                padding: 0.25rem 0.75rem;
                background: var(--bg-tertiary);
                color: var(--text-tertiary);
                border-radius: 9999px;
                font-size: 0.875rem;
                font-weight: 500;
            `;
            heading.appendChild(badge);
        }
    });
}

// ============================================================================
// ACCESSIBILITY: FOCUS INDICATORS & SKIP LINK
// ============================================================================

function enhanceAccessibility() {
    const style = document.createElement('style');
    style.textContent = `
        *:focus-visible {
            outline: 2px solid var(--primary);
            outline-offset: 2px;
            border-radius: 0.25rem;
        }

        a:focus-visible, button:focus-visible {
            outline: 3px solid var(--primary);
        }

        /* Skip to main content link */
        .skip-to-main {
            position: absolute;
            top: -40px;
            left: 0;
            background: var(--primary);
            color: var(--bg-primary);
            padding: 0.5rem 1rem;
            text-decoration: none;
            z-index: 10000;
        }

        .skip-to-main:focus {
            top: 0;
        }
    `;
    document.head.appendChild(style);

    // Add skip to main content link
    const skipLink = document.createElement('a');
    skipLink.href = '#hero';
    skipLink.className = 'skip-to-main';
    skipLink.textContent = 'Skip to main content';
    document.body.insertBefore(skipLink, document.body.firstChild);
}

// ============================================================================
// PERFORMANCE: LAZY LOAD IMAGES
// ============================================================================

function lazyLoadImages() {
    const imageObserver = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                const img = entry.target;
                if (img.dataset.src) {
                    img.src = img.dataset.src;
                    img.classList.remove('lazy');
                    imageObserver.unobserve(img);
                }
            }
        });
    });

    document.querySelectorAll('img[data-src]').forEach(img => {
        imageObserver.observe(img);
    });
}

// ============================================================================
// SMOOTH SCROLL BEHAVIOR
// ============================================================================

function enableSmoothScroll() {
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                target.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        });
    });
}

// ============================================================================
// TABLE OF CONTENTS GENERATOR
// ============================================================================

function generateTableOfContents() {
    const headings = document.querySelectorAll('h2, h3');
    if (headings.length < 5) return; // Only generate if there are enough headings

    const tocContainer = document.createElement('div');
    tocContainer.id = 'table-of-contents';
    tocContainer.style.cssText = `
        position: fixed;
        right: 2rem;
        top: 100px;
        width: 250px;
        max-height: calc(100vh - 150px);
        overflow-y: auto;
        background: var(--bg-secondary);
        border: 1px solid var(--border-primary);
        border-radius: 0.5rem;
        padding: 1rem;
        display: none;
        z-index: 100;
    `;

    const tocTitle = document.createElement('h4');
    tocTitle.textContent = 'Table of Contents';
    tocTitle.style.cssText = `
        color: var(--primary);
        margin-bottom: 1rem;
        font-size: 1rem;
    `;
    tocContainer.appendChild(tocTitle);

    const tocList = document.createElement('ul');
    tocList.style.cssText = `
        list-style: none;
        padding: 0;
        margin: 0;
    `;

    headings.forEach((heading, index) => {
        const id = heading.id || `heading-${index}`;
        heading.id = id;

        const li = document.createElement('li');
        li.style.cssText = `
            margin: 0.5rem 0;
            padding-left: ${heading.tagName === 'H3' ? '1rem' : '0'};
        `;

        const link = document.createElement('a');
        link.href = `#${id}`;
        link.textContent = heading.textContent.replace(/\d+\smin\sread/, '').trim();
        link.style.cssText = `
            color: var(--text-secondary);
            font-size: 0.875rem;
            text-decoration: none;
            transition: color 0.2s;
        `;
        link.addEventListener('mouseover', () => link.style.color = 'var(--primary)');
        link.addEventListener('mouseout', () => link.style.color = 'var(--text-secondary)');

        li.appendChild(link);
        tocList.appendChild(li);
    });

    tocContainer.appendChild(tocList);
    document.body.appendChild(tocContainer);

    // Show/hide TOC on larger screens
    if (window.innerWidth > 1400) {
        tocContainer.style.display = 'block';
    }

    window.addEventListener('resize', debounce(() => {
        tocContainer.style.display = window.innerWidth > 1400 ? 'block' : 'none';
    }, 300));
}

// ============================================================================
// INITIALIZE ALL FEATURES
// ============================================================================

document.addEventListener('DOMContentLoaded', () => {
    // Core features
    updateActiveLink();

    // Advanced features
    createProgressBar();
    createAdvancedSearch();
    initializeExpandableCards();
    initializeSyntaxHighlighting();
    animateStatistics();
    initializeScrollAnimations();
    initializeParallax();
    addReadingTime();
    enhanceAccessibility();
    lazyLoadImages();
    enableSmoothScroll();
    generateTableOfContents();

    // Log initialization (for debugging)
    console.log('%c🌟 Claude Code Documentation Enhanced!',
        'color: #3DD6C7; font-size: 16px; font-weight: bold;');
    console.log('%cFeatures Loaded:', 'color: #6366F1; font-size: 12px; font-weight: bold;');
    console.log('%c✓ Advanced Search with Keyboard Navigation', 'color: #34D399; font-size: 11px;');
    console.log('%c✓ Expandable Agent Cards', 'color: #34D399; font-size: 11px;');
    console.log('%c✓ Syntax Highlighting', 'color: #34D399; font-size: 11px;');
    console.log('%c✓ Reading Progress Bar', 'color: #34D399; font-size: 11px;');
    console.log('%c✓ Animated Statistics', 'color: #34D399; font-size: 11px;');
    console.log('%c✓ Scroll Animations', 'color: #34D399; font-size: 11px;');
    console.log('%c✓ Parallax Effects', 'color: #34D399; font-size: 11px;');
    console.log('%c✓ Reading Time Estimator', 'color: #34D399; font-size: 11px;');
    console.log('%c✓ Accessibility Enhancements', 'color: #34D399; font-size: 11px;');
    console.log('%c✓ Table of Contents', 'color: #34D399; font-size: 11px;');
});
