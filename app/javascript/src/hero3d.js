import * as THREE from 'three';
import { gsap } from 'gsap';
import { ScrollTrigger } from 'gsap/ScrollTrigger';

gsap.registerPlugin(ScrollTrigger);

export class Hero3D {
  constructor(containerId) {
    this.container = document.getElementById(containerId);
    if (!this.container) return;

    this.scene = null;
    this.camera = null;
    this.renderer = null;
    this.agents = [];
    this.particles = null;
    this.codeParticles = null;
    this.mouseX = 0;
    this.mouseY = 0;
    this.targetX = 0;
    this.targetY = 0;
    this.animationId = null;
    this.time = 0;

    // Interaction state
    this.raycaster = new THREE.Raycaster();
    this.pointer = new THREE.Vector2();
    this.hoveredAgent = null;
    this.clickedAgent = null;
    this.messagePaths = [];
    this.mouseTrailParticles = [];
    this.lastMousePos = new THREE.Vector2();
    this.isReducedMotion = window.matchMedia('(prefers-reduced-motion: reduce)').matches;

    // Agent data for hover reveals
    this.agentData = [
      { role: 'Architect', skill: 'System Design', desc: 'Designs scalable agent swarms' },
      { role: 'Coder', skill: 'TypeScript/Rust', desc: 'Implements core agent logic' },
      { role: 'Reviewer', skill: 'Code Quality', desc: 'Ensures robust, tested output' },
      { role: 'Tester', skill: 'E2E/Property', desc: 'Validates behavior at scale' },
      { role: 'Planner', skill: 'Task Decomposition', desc: 'Breaks goals into agent tasks' },
      { role: 'Optimizer', skill: 'Performance', desc: 'Profiles and accelerates flows' },
      { role: 'Integrator', skill: 'API/Infra', desc: 'Connects agents to tooling' },
      { role: 'Guardian', skill: 'Security', desc: 'Hardens agent boundaries' },
      { role: 'Analyst', skill: 'Observability', desc: 'Instruments agent behavior' },
      { role: 'Curator', skill: 'Knowledge', desc: 'Manages agent memory/context' },
      { role: 'Orchestrator', skill: 'Workflow', desc: 'Coordinates multi-agent runs' },
      { role: 'Innovator', skill: 'R&D', desc: 'Explores novel agent patterns' },
    ];

    this.init();
    this.animate();
    this.bindEvents();
  }

  init() {
    // Scene
    this.scene = new THREE.Scene();

    // Camera - wider FOV for more dramatic perspective
    this.camera = new THREE.PerspectiveCamera(
      60,
      this.container.clientWidth / this.container.clientHeight,
      0.1,
      1000
    );
    this.camera.position.z = 50;

    // Renderer with alpha for transparency
    this.renderer = new THREE.WebGLRenderer({
      antialias: true,
      alpha: true,
      powerPreference: 'high-performance',
    });
    this.renderer.setSize(this.container.clientWidth, this.container.clientHeight);
    this.renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2));
    this.renderer.setClearColor(0x000000, 0);
    this.container.appendChild(this.renderer.domElement);

    // Create agent swarm
    this.createAgents();

    // Create floating code particles
    this.createCodeParticles();

    // Create ambient particles
    this.createParticles();

    // Lights
    this.createLights();

    // Handle resize
    window.addEventListener('resize', () => this.onResize());
  }

  createAgents() {
    // Create 12 AI agents as geometric shapes
    const agentCount = 12;
    const geometries = [
      new THREE.OctahedronGeometry(1.2, 0),
      new THREE.IcosahedronGeometry(1.2, 0),
      new THREE.TetrahedronGeometry(1.5, 0),
      new THREE.DodecahedronGeometry(1.1, 0),
    ];

    const materials = [
      new THREE.MeshPhysicalMaterial({
        color: 0x2563eb,
        metalness: 0.3,
        roughness: 0.2,
        clearcoat: 0.5,
        clearcoatRoughness: 0.1,
        transparent: true,
        opacity: 0.85,
      }),
      new THREE.MeshPhysicalMaterial({
        color: 0x38bdf8,
        metalness: 0.4,
        roughness: 0.15,
        clearcoat: 0.6,
        clearcoatRoughness: 0.08,
        transparent: true,
        opacity: 0.8,
      }),
      new THREE.MeshPhysicalMaterial({
        color: 0x06b6d4,
        metalness: 0.35,
        roughness: 0.18,
        clearcoat: 0.55,
        clearcoatRoughness: 0.09,
        transparent: true,
        opacity: 0.82,
      }),
      new THREE.MeshPhysicalMaterial({
        color: 0x8b5cf6,
        metalness: 0.25,
        roughness: 0.22,
        clearcoat: 0.45,
        clearcoatRoughness: 0.12,
        transparent: true,
        opacity: 0.78,
      }),
    ];

    for (let i = 0; i < agentCount; i++) {
      const geometry = geometries[i % geometries.length];
      const material = materials[i % materials.length].clone();

      const agent = new THREE.Mesh(geometry, material);

      // Position in a sphere-ish formation
      const radius = 18 + Math.random() * 8;
      const theta = (i / agentCount) * Math.PI * 2 + Math.random() * 0.5;
      const phi = Math.acos(2 * Math.random() - 1);

      agent.position.setFromSphericalCoords(radius, phi, theta);
      agent.userData = {
        originalPosition: agent.position.clone(),
        radius,
        theta,
        phi,
        speed: 0.0008 + Math.random() * 0.0012,
        originalSpeed: 0.0008 + Math.random() * 0.0012,
        rotationSpeed: new THREE.Euler(
          (Math.random() - 0.5) * 0.008,
          (Math.random() - 0.5) * 0.008,
          (Math.random() - 0.5) * 0.008
        ),
        pulsePhase: Math.random() * Math.PI * 2,
        pulseSpeed: 0.003 + Math.random() * 0.004,
        connections: [],
      };

      this.scene.add(agent);
      this.agents.push(agent);
    }

    // Create connection lines between nearby agents
    this.createConnections();
  }

  createConnections() {
    const connectionMaterial = new THREE.LineBasicMaterial({
      color: 0x2563eb,
      transparent: true,
      opacity: 0.15,
      linewidth: 1,
    });

    for (let i = 0; i < this.agents.length; i++) {
      for (let j = i + 1; j < this.agents.length; j++) {
        const dist = this.agents[i].position.distanceTo(this.agents[j].position);
        if (dist < 22) {
          const geometry = new THREE.BufferGeometry();
          const positions = new Float32Array(6);
          geometry.setAttribute('position', new THREE.BufferAttribute(positions, 3));
          const line = new THREE.Line(geometry, connectionMaterial.clone());
          line.userData = { agentA: i, agentB: j };
          this.scene.add(line);
          this.agents[i].userData.connections.push(line);
          this.agents[j].userData.connections.push(line);
        }
      }
    }
  }

  createCodeParticles() {
    // Floating code snippets / brackets / symbols
    const codeSymbols = [
      '{', '}', '[', ']', '(', ')',
      '=>', '::', '->', '|>',
      'fn', 'let', 'const', 'async',
      'await', 'return', 'if', 'else',
      'class', 'struct', 'impl', 'trait',
      'Agent', 'Task', 'Flow', 'Stream',
      '∥', '⟳', '⚡', '◈',
    ];

    const count = 150;
    const geometry = new THREE.BufferGeometry();
    const positions = new Float32Array(count * 3);
    const sizes = new Float32Array(count);
    const colors = new Float32Array(count * 3);
    const alphas = new Float32Array(count);
    const symbols = [];
    const velocities = [];

    for (let i = 0; i < count; i++) {
      const i3 = i * 3;
      // Distribute in a large sphere around the scene
      const radius = 35 + Math.random() * 40;
      const theta = Math.random() * Math.PI * 2;
      const phi = Math.acos(2 * Math.random() - 1);

      positions[i3] = radius * Math.sin(phi) * Math.cos(theta);
      positions[i3 + 1] = radius * Math.sin(phi) * Math.sin(theta);
      positions[i3 + 2] = radius * Math.cos(phi);

      sizes[i] = 0.3 + Math.random() * 0.6;

      // Blue/cyan/purple gradient
      const colorChoice = Math.random();
      if (colorChoice < 0.33) {
        colors[i3] = 0.15; colors[i3 + 1] = 0.4; colors[i3 + 2] = 0.95; // blue
      } else if (colorChoice < 0.66) {
        colors[i3] = 0.22; colors[i3 + 1] = 0.74; colors[i3 + 2] = 0.97; // cyan
      } else {
        colors[i3] = 0.55; colors[i3 + 1] = 0.36; colors[i3 + 2] = 0.96; // purple
      }

      alphas[i] = 0.15 + Math.random() * 0.25;
      symbols.push(codeSymbols[Math.floor(Math.random() * codeSymbols.length)]);
      velocities.push({
        x: (Math.random() - 0.5) * 0.02,
        y: (Math.random() - 0.5) * 0.02,
        z: (Math.random() - 0.5) * 0.02,
      });
    }

    geometry.setAttribute('position', new THREE.BufferAttribute(positions, 3));
    geometry.setAttribute('size', new THREE.BufferAttribute(sizes, 1));
    geometry.setAttribute('color', new THREE.BufferAttribute(colors, 3));
    geometry.setAttribute('alpha', new THREE.BufferAttribute(alphas, 1));

    const material = new THREE.PointsMaterial({
      size: 1,
      vertexColors: true,
      transparent: true,
      opacity: 1,
      sizeAttenuation: true,
      depthWrite: false,
      blending: THREE.AdditiveBlending,
    });

    this.codeParticles = new THREE.Points(geometry, material);
    this.codeParticles.userData = { symbols, velocities };
    this.scene.add(this.codeParticles);
  }

  createParticles() {
    // Ambient glow particles
    const count = 800;
    const geometry = new THREE.BufferGeometry();
    const positions = new Float32Array(count * 3);
    const sizes = new Float32Array(count);
    const colors = new Float32Array(count * 3);
    const alphas = new Float32Array(count);

    for (let i = 0; i < count; i++) {
      const i3 = i * 3;
      const radius = 25 + Math.random() * 50;
      const theta = Math.random() * Math.PI * 2;
      const phi = Math.acos(2 * Math.random() - 1);

      positions[i3] = radius * Math.sin(phi) * Math.cos(theta);
      positions[i3 + 1] = radius * Math.sin(phi) * Math.sin(theta);
      positions[i3 + 2] = radius * Math.cos(phi);

      sizes[i] = 0.15 + Math.random() * 0.4;

      const colorChoice = Math.random();
      if (colorChoice < 0.4) {
        colors[i3] = 0.15; colors[i3 + 1] = 0.4; colors[i3 + 2] = 0.95;
      } else if (colorChoice < 0.7) {
        colors[i3] = 0.22; colors[i3 + 1] = 0.74; colors[i3 + 2] = 0.97;
      } else {
        colors[i3] = 0.55; colors[i3 + 1] = 0.36; colors[i3 + 2] = 0.96;
      }

      alphas[i] = 0.05 + Math.random() * 0.15;
    }

    geometry.setAttribute('position', new THREE.BufferAttribute(positions, 3));
    geometry.setAttribute('size', new THREE.BufferAttribute(sizes, 1));
    geometry.setAttribute('color', new THREE.BufferAttribute(colors, 3));
    geometry.setAttribute('alpha', new THREE.BufferAttribute(alphas, 1));

    const material = new THREE.PointsMaterial({
      size: 1,
      vertexColors: true,
      transparent: true,
      opacity: 1,
      sizeAttenuation: true,
      depthWrite: false,
      blending: THREE.AdditiveBlending,
    });

    this.particles = new THREE.Points(geometry, material);
    this.scene.add(this.particles);
  }

  createLights() {
    // Ambient light
    const ambient = new THREE.AmbientLight(0xffffff, 0.4);
    this.scene.add(ambient);

    // Main directional light
    const mainLight = new THREE.DirectionalLight(0x2563eb, 1.2);
    mainLight.position.set(20, 30, 25);
    this.scene.add(mainLight);

    // Rim light
    const rimLight = new THREE.DirectionalLight(0x38bdf8, 0.6);
    rimLight.position.set(-20, -10, -20);
    this.scene.add(rimLight);

    // Accent point lights that orbit
    this.accentLights = [];
    for (let i = 0; i < 3; i++) {
      const light = new THREE.PointLight(
        [0x2563eb, 0x38bdf8, 0x8b5cf6][i],
        2,
        60
      );
      light.position.set(
        Math.cos(i * 2.1) * 30,
        Math.sin(i * 1.7) * 15,
        Math.sin(i * 2.3) * 30
      );
      this.scene.add(light);
      this.accentLights.push(light);
    }
  }

  bindEvents() {
    // Mouse move for parallax
    document.addEventListener('mousemove', (e) => {
      this.mouseX = (e.clientX / window.innerWidth) * 2 - 1;
      this.mouseY = -(e.clientY / window.innerHeight) * 2 + 1;

      // Update pointer for raycasting
      this.pointer.x = (e.clientX / window.innerWidth) * 2 - 1;
      this.pointer.y = -(e.clientY / window.innerHeight) * 2 + 1;

      // Emit mouse trail particles occasionally
      if (!this.isReducedMotion && Math.random() < 0.15) {
        this.emitMouseTrail(e.clientX, e.clientY);
      }
    });

    // Touch support
    document.addEventListener('touchmove', (e) => {
      if (e.touches[0]) {
        this.mouseX = (e.touches[0].clientX / window.innerWidth) * 2 - 1;
        this.mouseY = -(e.touches[0].clientY / window.innerHeight) * 2 + 1;
        this.pointer.x = (e.touches[0].clientX / window.innerWidth) * 2 - 1;
        this.pointer.y = -(e.touches[0].clientY / window.innerHeight) * 2 + 1;
      }
    }, { passive: true });

    // Click handler for agent selection
    this.container.addEventListener('click', (e) => this.onContainerClick(e));

    // Keyboard navigation for accessibility
    this.container.addEventListener('keydown', (e) => this.onKeyDown(e));
    this.container.setAttribute('tabindex', '0');
    this.container.setAttribute('role', 'region');
    this.container.setAttribute('aria-label', 'Interactive 3D agent visualization');

    // Scroll-based camera movement
    gsap.to(this.camera.position, {
      z: 30,
      ease: 'none',
      scrollTrigger: {
        trigger: '#home',
        start: 'top top',
        end: 'bottom top',
        scrub: 1,
        onUpdate: (self) => this.onScrollProgress(self.progress),
      },
    });

    // Rotate scene on scroll
    gsap.to(this.scene.rotation, {
      y: Math.PI * 0.15,
      ease: 'none',
      scrollTrigger: {
        trigger: '#home',
        start: 'top top',
        end: 'bottom top',
        scrub: 1,
      },
    });

    // Trigger agent conversations at scroll milestones
    this.setupConversationTriggers();
  }

  setupConversationTriggers() {
    const milestones = [0.2, 0.4, 0.6, 0.8];
    milestones.forEach((progress, idx) => {
      ScrollTrigger.create({
        trigger: '#home',
        start: `top top`,
        end: 'bottom top',
        scrub: false,
        onEnter: () => {
          if (self.progress >= progress && !this.conversationTriggered[idx]) {
            this.conversationTriggered[idx] = true;
            this.triggerAgentConversation(idx);
          }
        },
        onLeaveBack: () => {
          this.conversationTriggered[idx] = false;
        },
      });
    });
    this.conversationTriggered = new Array(milestones.length).fill(false);
  }

  onContainerClick(e) {
    this.raycaster.setFromCamera(this.pointer, this.camera);
    const intersects = this.raycaster.intersectObjects(this.agents, true);

    if (intersects.length > 0) {
      const agent = intersects[0].object;
      this.selectAgent(agent);
    } else {
      this.deselectAgent();
    }
  }

  onKeyDown(e) {
    if (e.key === 'Tab') {
      // Focus management for keyboard navigation
      if (this.hoveredAgent) {
        e.preventDefault();
        this.selectAgent(this.hoveredAgent);
      }
    } else if (e.key === 'Escape') {
      this.deselectAgent();
    } else if (e.key === 'Enter' || e.key === ' ') {
      if (this.hoveredAgent && !this.clickedAgent) {
        e.preventDefault();
        this.selectAgent(this.hoveredAgent);
      }
    }
  }

  selectAgent(agent) {
    if (this.clickedAgent === agent) return;

    this.deselectAgent();
    this.clickedAgent = agent;
    agent.userData.isSelected = true;

    // Visual feedback: brighten, enlarge, stop orbiting
    gsap.to(agent.material, { opacity: 1, duration: 0.3, ease: 'power2.out' });
    gsap.to(agent.scale, { x: 1.5, y: 1.5, z: 1.5, duration: 0.4, ease: 'elastic.out(1, 0.5)' });
    gsap.to(agent.userData, { speed: 0, duration: 0.3 });

    // Highlight connections
    agent.userData.connections.forEach(line => {
      gsap.to(line.material, { opacity: 0.6, duration: 0.3 });
    });

    // Show info panel
    this.showAgentInfo(agent);
  }

  deselectAgent() {
    if (!this.clickedAgent) return;

    const agent = this.clickedAgent;
    agent.userData.isSelected = false;

    // Restore visual state
    gsap.to(agent.material, { opacity: 0.85, duration: 0.5, ease: 'power2.out' });
    gsap.to(agent.scale, { x: 1, y: 1, z: 1, duration: 0.5, ease: 'elastic.out(1, 0.5)' });
    gsap.to(agent.userData, { speed: agent.userData.originalSpeed || 0.001, duration: 0.3 });

    // Restore connections
    agent.userData.connections.forEach(line => {
      gsap.to(line.material, { opacity: 0.15, duration: 0.5 });
    });

    this.hideAgentInfo();
    this.clickedAgent = null;
  }

  showAgentInfo(agent) {
    const idx = this.agents.indexOf(agent);
    const data = this.agentData[idx] || this.agentData[0];

    // Remove existing panel
    this.hideAgentInfo();

    const panel = document.createElement('div');
    panel.id = 'agent-info-panel';
    panel.className = 'fixed pointer-events-none z-50 transition-opacity duration-300';
    panel.style.cssText = `
      background: rgba(3, 7, 18, 0.95);
      border: 1px solid rgba(56, 189, 248, 0.3);
      border-radius: 12px;
      padding: 16px 20px;
      min-width: 200px;
      max-width: 280px;
      backdrop-filter: blur(12px);
      box-shadow: 0 20px 40px -10px rgba(0, 0, 0, 0.5);
    `;

    // Position near agent's screen position
    const vector = new THREE.Vector3();
    vector.setFromMatrixPosition(agent.matrixWorld);
    vector.project(this.camera);
    const x = (vector.x * 0.5 + 0.5) * window.innerWidth;
    const y = (vector.y * -0.5 + 0.5) * window.innerHeight;
    panel.style.left = `${Math.min(Math.max(x - 140, 20), window.innerWidth - 300)}px`;
    panel.style.top = `${Math.max(y - 160, 100)}px`;

    panel.innerHTML = `
      <div style="color: #38bdf8; font-size: 11px; font-weight: 600; text-transform: uppercase; letter-spacing: 0.1em; margin-bottom: 4px;">${data.role}</div>
      <div style="color: #fff; font-size: 18px; font-weight: 700; margin-bottom: 4px;">${data.skill}</div>
      <div style="color: #94a3b8; font-size: 13px; line-height: 1.5;">${data.desc}</div>
    `;

    document.body.appendChild(panel);

    // Animate in
    panel.style.opacity = '0';
    panel.style.transform = 'translateY(10px)';
    requestAnimationFrame(() => {
      panel.style.transition = 'opacity 0.3s ease, transform 0.3s ease';
      panel.style.opacity = '1';
      panel.style.transform = 'translateY(0)';
    });

    this.infoPanel = panel;
  }

  hideAgentInfo() {
    if (this.infoPanel) {
      this.infoPanel.style.opacity = '0';
      this.infoPanel.style.transform = 'translateY(-10px)';
      setTimeout(() => {
        if (this.infoPanel && this.infoPanel.parentNode) {
          this.infoPanel.parentNode.removeChild(this.infoPanel);
        }
        this.infoPanel = null;
      }, 300);
    }
  }

  emitMouseTrail(clientX, clientY) {
    // Create a small burst of particles at mouse position
    const count = 3 + Math.floor(Math.random() * 3);
    const trailGeometry = new THREE.BufferGeometry();
    const positions = new Float32Array(count * 3);
    const sizes = new Float32Array(count);
    const colors = new Float32Array(count * 3);
    const alphas = new Float32Array(count);
    const velocities = [];

    // Convert screen to world space (near plane)
    const vector = new THREE.Vector3();
    vector.set(
      (clientX / window.innerWidth) * 2 - 1,
      -(clientY / window.innerHeight) * 2 + 1,
      0.5
    );
    vector.unproject(this.camera);
    const dir = vector.sub(this.camera.position).normalize();
    const worldPos = this.camera.position.clone().add(dir.multiplyScalar(20));

    for (let i = 0; i < count; i++) {
      const i3 = i * 3;
      positions[i3] = worldPos.x + (Math.random() - 0.5) * 2;
      positions[i3 + 1] = worldPos.y + (Math.random() - 0.5) * 2;
      positions[i3 + 2] = worldPos.z + (Math.random() - 0.5) * 2;

      sizes[i] = 0.2 + Math.random() * 0.3;

      const colorChoice = Math.random();
      if (colorChoice < 0.5) {
        colors[i3] = 0.15; colors[i3 + 1] = 0.4; colors[i3 + 2] = 0.95;
      } else {
        colors[i3] = 0.55; colors[i3 + 1] = 0.36; colors[i3 + 2] = 0.96;
      }

      alphas[i] = 0.6 + Math.random() * 0.4;
      velocities.push({
        x: (Math.random() - 0.5) * 0.1,
        y: (Math.random() - 0.5) * 0.1,
        z: (Math.random() - 0.5) * 0.1,
        life: 1.0,
        decay: 0.02 + Math.random() * 0.02,
      });
    }

    trailGeometry.setAttribute('position', new THREE.BufferAttribute(positions, 3));
    trailGeometry.setAttribute('size', new THREE.BufferAttribute(sizes, 1));
    trailGeometry.setAttribute('color', new THREE.BufferAttribute(colors, 3));
    trailGeometry.setAttribute('alpha', new THREE.BufferAttribute(alphas, 1));

    const trailMaterial = new THREE.PointsMaterial({
      size: 1,
      vertexColors: true,
      transparent: true,
      opacity: 1,
      sizeAttenuation: true,
      depthWrite: false,
      blending: THREE.AdditiveBlending,
    });

    const trail = new THREE.Points(trailGeometry, trailMaterial);
    trail.userData = { velocities, birthTime: this.time };
    this.scene.add(trail);
    this.mouseTrailParticles.push(trail);

    // Clean up old trails
    if (this.mouseTrailParticles.length > 30) {
      const old = this.mouseTrailParticles.shift();
      this.scene.remove(old);
      old.geometry.dispose();
      old.material.dispose();
    }
  }

  triggerAgentConversation(convoIndex) {
    if (this.agents.length < 2) return;

    // Pick two random agents that are somewhat close
    let agentA, agentB, attempts = 0;
    do {
      agentA = this.agents[Math.floor(Math.random() * this.agents.length)];
      agentB = this.agents[Math.floor(Math.random() * this.agents.length)];
      attempts++;
    } while (agentA === agentB && attempts < 10);

    if (agentA === agentB) return;

    // Create animated message path
    this.createMessagePath(agentA, agentB, convoIndex);
  }

  createMessagePath(agentA, agentB, styleIndex) {
    const colors = [0x38bdf8, 0x22d3ee, 0xa78bfa, 0xf472b6];
    const color = colors[styleIndex % colors.length];

    // Create a curved path between agents
    const curve = new THREE.QuadraticBezierCurve3(
      agentA.position.clone(),
      new THREE.Vector3()
        .addVectors(agentA.position, agentB.position)
        .multiplyScalar(0.5)
        .add(new THREE.Vector3(
          (Math.random() - 0.5) * 10,
          (Math.random() - 0.5) * 10,
          (Math.random() - 0.5) * 10
        )),
      agentB.position.clone()
    );

    const points = curve.getPoints(30);
    const geometry = new THREE.BufferGeometry().setFromPoints(points);

    const material = new THREE.LineBasicMaterial({
      color,
      transparent: true,
      opacity: 0,
      linewidth: 2,
    });

    const line = new THREE.Line(geometry, material);
    this.scene.add(line);

    // Animate the message traveling along the path
    const duration = 1.5 + Math.random() * 1;
    const progress = { value: 0 };

    gsap.to(progress, {
      value: 1,
      duration,
      ease: 'power2.inOut',
      onUpdate: () => {
        const p = progress.value;
        const visiblePoints = Math.floor(p * points.length);
        if (visiblePoints > 1) {
          const visibleGeometry = new THREE.BufferGeometry().setFromPoints(points.slice(0, visiblePoints));
          line.geometry.dispose();
          line.geometry = visibleGeometry;
          material.opacity = Math.sin(p * Math.PI) * 0.8;
        }
      },
      onComplete: () => {
        // Pulse at destination
        gsap.to(agentB.scale, {
          x: 1.3, y: 1.3, z: 1.3,
          duration: 0.2,
          yoyo: true,
          repeat: 1,
          ease: 'power2.out',
        });
        // Fade out line
        gsap.to(material, { opacity: 0, duration: 0.5, onComplete: () => {
          this.scene.remove(line);
          line.geometry.dispose();
          material.dispose();
        }});
      },
    });

    // Also pulse source agent
    gsap.to(agentA.scale, {
      x: 1.2, y: 1.2, z: 1.2,
      duration: 0.15,
      yoyo: true,
      repeat: 1,
      ease: 'power2.out',
    });
  }

  onScrollProgress(progress) {
    // Trigger conversations based on scroll
    // This is handled by ScrollTrigger callbacks in setupConversationTriggers
  }

  onResize() {
    if (!this.container) return;
    this.camera.aspect = this.container.clientWidth / this.container.clientHeight;
    this.camera.updateProjectionMatrix();
    this.renderer.setSize(this.container.clientWidth, this.container.clientHeight);
  }

  animate() {
    this.animationId = requestAnimationFrame(() => this.animate());
    this.time += 0.016; // ~60fps

    // Smooth mouse follow
    this.targetX += (this.mouseX - this.targetX) * 0.04;
    this.targetY += (this.mouseY - this.targetY) * 0.04;

    // Camera subtle parallax
    this.camera.position.x += (this.targetX * 3 - this.camera.position.x) * 0.02;
    this.camera.position.y += (this.targetY * 2 - this.camera.position.y) * 0.02;
    this.camera.lookAt(0, 0, 0);

    // Raycast for hover detection (skip if reduced motion or agent selected)
    if (!this.isReducedMotion && !this.clickedAgent) {
      this.raycaster.setFromCamera(this.pointer, this.camera);
      const intersects = this.raycaster.intersectObjects(this.agents, true);

      if (intersects.length > 0) {
        const hoveredAgent = intersects[0].object;
        if (this.hoveredAgent !== hoveredAgent) {
          this.onAgentHoverEnter(hoveredAgent);
        }
        this.hoveredAgent = hoveredAgent;
      } else if (this.hoveredAgent) {
        this.onAgentHoverLeave(this.hoveredAgent);
        this.hoveredAgent = null;
      }
    }

    // Animate agents
    this.agents.forEach((agent, i) => {
      const data = agent.userData;

      // Skip orbital motion if selected
      if (!data.isSelected) {
        // Orbital motion
        data.theta += data.speed;
        data.phi += data.speed * 0.3;

        const targetPos = new THREE.Vector3().setFromSphericalCoords(
          data.radius,
          data.phi,
          data.theta
        );

        // Add mouse influence
        targetPos.x += this.targetX * 2;
        targetPos.y += this.targetY * 1.5;

        // Smooth position interpolation
        agent.position.lerp(targetPos, 0.02);
      }

      // Rotation (always)
      agent.rotation.x += data.rotationSpeed.x;
      agent.rotation.y += data.rotationSpeed.y;
      agent.rotation.z += data.rotationSpeed.z;

      // Pulse scale (skip if selected)
      if (!data.isSelected) {
        data.pulsePhase += data.pulseSpeed;
        const pulse = 1 + Math.sin(data.pulsePhase) * 0.08;
        agent.scale.setScalar(pulse);
      }

      // Update connections
      data.connections.forEach((line) => {
        const positions = line.geometry.attributes.position.array;
        const agentA = this.agents[line.userData.agentA];
        const agentB = this.agents[line.userData.agentB];
        positions[0] = agentA.position.x;
        positions[1] = agentA.position.y;
        positions[2] = agentA.position.z;
        positions[3] = agentB.position.x;
        positions[4] = agentB.position.y;
        positions[5] = agentB.position.z;
        line.geometry.attributes.position.needsUpdate = true;

        // Pulse opacity based on distance
        const dist = agentA.position.distanceTo(agentB.position);
        const baseOpacity = data.isSelected ? 0.6 : 0.15;
        const maxOpacity = data.isSelected ? 0.8 : 0.25;
        line.material.opacity = THREE.MathUtils.lerp(baseOpacity, maxOpacity, 1 - dist / 30);
      });

      // Update accent lights orbit
      if (this.accentLights[i]) {
        const angle = this.time * 0.15 + i * 2.1;
        this.accentLights[i].position.x = Math.cos(angle) * 35;
        this.accentLights[i].position.z = Math.sin(angle) * 35;
        this.accentLights[i].position.y = Math.sin(angle * 0.7) * 20;
      }
    });

    // Animate mouse trail particles
    this.animateMouseTrails();

    // Animate code particles - slow drift
    if (this.codeParticles) {
      const positions = this.codeParticles.geometry.attributes.position.array;
      const velocities = this.codeParticles.userData.velocities;

      for (let i = 0; i < velocities.length; i++) {
        const i3 = i * 3;
        positions[i3] += velocities[i].x;
        positions[i3 + 1] += velocities[i].y;
        positions[i3 + 2] += velocities[i].z;

        // Wrap around
        const dist = Math.sqrt(
          positions[i3] ** 2 + positions[i3 + 1] ** 2 + positions[i3 + 2] ** 2
        );
        if (dist > 80) {
          // Respawn on opposite side
          positions[i3] = -positions[i3] * 0.5;
          positions[i3 + 1] = -positions[i3 + 1] * 0.5;
          positions[i3 + 2] = -positions[i3 + 2] * 0.5;
        }
      }
      this.codeParticles.geometry.attributes.position.needsUpdate = true;
      this.codeParticles.rotation.y += 0.0001;
      this.codeParticles.rotation.x += 0.00005;
    }

    // Animate ambient particles
    if (this.particles) {
      this.particles.rotation.y += 0.00008;
      this.particles.rotation.x += 0.00003;
    }

    // Slow scene rotation
    this.scene.rotation.y += 0.00005;

    // Update info panel position if visible
    if (this.infoPanel && this.clickedAgent) {
      this.updateInfoPanelPosition();
    }

    this.renderer.render(this.scene, this.camera);
  }

  onAgentHoverEnter(agent) {
    if (agent.userData.isSelected) return;

    agent.userData.isHovered = true;
    gsap.to(agent.material, { opacity: 1, duration: 0.2, ease: 'power2.out' });
    gsap.to(agent.scale, { x: 1.2, y: 1.2, z: 1.2, duration: 0.3, ease: 'elastic.out(1, 0.5)' });

    // Brighten connections
    agent.userData.connections.forEach(line => {
      gsap.to(line.material, { opacity: 0.4, duration: 0.2 });
    });
  }

  onAgentHoverLeave(agent) {
    if (agent.userData.isSelected) return;

    agent.userData.isHovered = false;
    gsap.to(agent.material, { opacity: 0.85, duration: 0.3, ease: 'power2.out' });
    gsap.to(agent.scale, { x: 1, y: 1, z: 1, duration: 0.4, ease: 'elastic.out(1, 0.5)' });

    // Restore connections
    agent.userData.connections.forEach(line => {
      gsap.to(line.material, { opacity: 0.15, duration: 0.3 });
    });
  }

  animateMouseTrails() {
    for (let i = this.mouseTrailParticles.length - 1; i >= 0; i--) {
      const trail = this.mouseTrailParticles[i];
      const positions = trail.geometry.attributes.position.array;
      const velocities = trail.userData.velocities;

      let allDead = true;
      for (let j = 0; j < velocities.length; j++) {
        const j3 = j * 3;
        velocities[j].life -= velocities[j].decay;
        if (velocities[j].life > 0) {
          allDead = false;
          positions[j3] += velocities[j].x;
          positions[j3 + 1] += velocities[j].y;
          positions[j3 + 2] += velocities[j].z;
          // Fade alpha
          const alphaAttr = trail.geometry.attributes.alpha;
          if (alphaAttr) {
            alphaAttr.array[j] = velocities[j].life * 0.8;
            alphaAttr.needsUpdate = true;
          }
        }
      }
      trail.geometry.attributes.position.needsUpdate = true;

      if (allDead) {
        this.scene.remove(trail);
        trail.geometry.dispose();
        trail.material.dispose();
        this.mouseTrailParticles.splice(i, 1);
      }
    }
  }

  updateInfoPanelPosition() {
    if (!this.infoPanel || !this.clickedAgent) return;

    const vector = new THREE.Vector3();
    vector.setFromMatrixPosition(this.clickedAgent.matrixWorld);
    vector.project(this.camera);
    const x = (vector.x * 0.5 + 0.5) * window.innerWidth;
    const y = (vector.y * -0.5 + 0.5) * window.innerHeight;

    this.infoPanel.style.left = `${Math.min(Math.max(x - 140, 20), window.innerWidth - 300)}px`;
    this.infoPanel.style.top = `${Math.max(y - 160, 100)}px`;
  }

  destroy() {
    if (this.animationId) {
      cancelAnimationFrame(this.animationId);
    }

    // Clean up mouse trail particles
    this.mouseTrailParticles.forEach(trail => {
      this.scene.remove(trail);
      trail.geometry.dispose();
      trail.material.dispose();
    });
    this.mouseTrailParticles = [];

    // Clean up info panel
    this.hideAgentInfo();

    // Clean up message paths
    this.messagePaths.forEach(path => {
      this.scene.remove(path.line);
      path.line.geometry.dispose();
      path.line.material.dispose();
    });
    this.messagePaths = [];

    // Clean up agents and connections
    this.agents.forEach(agent => {
      agent.userData.connections.forEach(line => {
        this.scene.remove(line);
        line.geometry.dispose();
        line.material.dispose();
      });
      this.scene.remove(agent);
      agent.geometry.dispose();
      agent.material.dispose();
    });
    this.agents = [];

    // Clean up particle systems
    if (this.codeParticles) {
      this.scene.remove(this.codeParticles);
      this.codeParticles.geometry.dispose();
      this.codeParticles.material.dispose();
    }
    if (this.particles) {
      this.scene.remove(this.particles);
      this.particles.geometry.dispose();
      this.particles.material.dispose();
    }

    // Clean up lights
    if (this.accentLights) {
      this.accentLights.forEach(light => this.scene.remove(light));
    }

    if (this.renderer) {
      this.renderer.dispose();
    }
    if (this.container && this.renderer?.domElement) {
      this.container.removeChild(this.renderer.domElement);
    }
    ScrollTrigger.getAll().forEach(t => t.kill());
  }
}

// Initialize on DOM ready
document.addEventListener('DOMContentLoaded', () => {
  const heroCanvas = document.getElementById('hero-canvas');
  if (heroCanvas) {
    window.hero3d = new Hero3D('hero-canvas');
  }
});

// Cleanup on Turbo visits
document.addEventListener('turbo:before-visit', () => {
  if (window.hero3d) {
    window.hero3d.destroy();
    window.hero3d = null;
  }
});