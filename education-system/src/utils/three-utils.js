// utils/three-utils.js - 完整版本

import * as THREE from 'three';
import { OrbitControls } from 'three/examples/jsm/controls/OrbitControls';

// 创建 Three.js 场景
export function createScene(container) {
  // 创建场景
  const scene = new THREE.Scene();
  scene.background = new THREE.Color(0x87CEEB);
  
  // 添加雾效果
  scene.fog = new THREE.Fog(0x87CEEB, 30, 100);
  
  // 创建相机
  const camera = new THREE.PerspectiveCamera(
    75,
    container.clientWidth / container.clientHeight,
    0.1,
    1000
  );
  camera.position.set(0, 20, 30);
  
  // 创建渲染器
  const renderer = new THREE.WebGLRenderer({ antialias: true });
  renderer.setSize(container.clientWidth, container.clientHeight);
  renderer.shadowMap.enabled = true;
  renderer.shadowMap.type = THREE.PCFSoftShadowMap;
  container.appendChild(renderer.domElement);
  
  // 添加控制器
  const controls = new OrbitControls(camera, renderer.domElement);
  controls.enableDamping = true;
  controls.dampingFactor = 0.05;
  controls.minPolarAngle = Math.PI / 6;
  controls.maxPolarAngle = Math.PI / 2;
  controls.minDistance = 10;
  controls.maxDistance = 50;
  
  // 添加增强版灯光
  const ambientLight = new THREE.AmbientLight(0xffffff, 0.6); // 稍微亮一点的环境光
  scene.add(ambientLight);
  
  // 主方向光（太阳）
  const directionalLight = new THREE.DirectionalLight(0xffffff, 0.8);
  directionalLight.position.set(30, 50, 30); // 更好的阴影位置
  directionalLight.castShadow = true;
  directionalLight.shadow.mapSize.width = 2048;
  directionalLight.shadow.mapSize.height = 2048;
  directionalLight.shadow.camera.near = 0.5;
  directionalLight.shadow.camera.far = 500;
  directionalLight.shadow.camera.left = -50;
  directionalLight.shadow.camera.right = 50;
  directionalLight.shadow.camera.top = 50;
  directionalLight.shadow.camera.bottom = -50;
  scene.add(directionalLight);
  
  // 添加辅助柔光，从相反方向填充阴影
  const secondaryLight = new THREE.DirectionalLight(0xffffff, 0.3);
  secondaryLight.position.set(-30, 40, -30);
  scene.add(secondaryLight);
  
  // 创建地面
  let groundMaterial;
  try {
    const textureLoader = new THREE.TextureLoader();
    const grassTexture = textureLoader.load('/textures/grass.jpg');
    grassTexture.wrapS = THREE.RepeatWrapping;
    grassTexture.wrapT = THREE.RepeatWrapping;
    grassTexture.repeat.set(20, 20);
    
    groundMaterial = new THREE.MeshStandardMaterial({ 
      map: grassTexture,
      roughness: 0.8,
    });
  } catch (e) {
    console.warn('Failed to load texture:', e);
    // 回退到基本材质
    groundMaterial = new THREE.MeshStandardMaterial({ 
      color: 0x7ec850,
      roughness: 0.8
    });
  }
  
  const groundGeometry = new THREE.PlaneGeometry(200, 200);
  const ground = new THREE.Mesh(groundGeometry, groundMaterial);
  ground.rotation.x = -Math.PI / 2;
  ground.receiveShadow = true;
  scene.add(ground);
  
  // 创建远处的山脉
  createMountains(scene);
  
  // 添加树木作为装饰
  addDecorations(scene);
  
  // 窗口大小调整处理
  function handleResize() {
    camera.aspect = container.clientWidth / container.clientHeight;
    camera.updateProjectionMatrix();
    renderer.setSize(container.clientWidth, container.clientHeight);
  }
  
  window.addEventListener('resize', handleResize);
  
  // 创建但不让它们成为响应式
  const raycaster = new THREE.Raycaster();
  const mouse = new THREE.Vector2();
  
  return {
    scene,
    camera,
    renderer,
    controls,
    raycaster,
    mouse,
    destroy: () => {
      window.removeEventListener('resize', handleResize);
      renderer.dispose();
      container.removeChild(renderer.domElement);
    }
  };
}

// 创建山脉背景
function createMountains(scene) {
  const mountainGeometry = new THREE.BufferGeometry();
  const mountainPositions = [];
  const mountainWidth = 200;
  const mountainDepth = 200;
  const segmentsX = 20;
  const segmentsZ = 20;
  
  for (let z = 0; z <= segmentsZ; z++) {
    for (let x = 0; x <= segmentsX; x++) {
      const xPos = (x / segmentsX) * mountainWidth - mountainWidth / 2;
      const zPos = (z / segmentsZ) * mountainDepth - mountainDepth / 2;
      
      // 生成山脉高度 - 越远高度越高，创造视觉深度
      let height = 0;
      const distanceFromCenter = Math.sqrt(xPos * xPos + zPos * zPos);
      
      if (distanceFromCenter > 30) {
        height = Math.sin(xPos * 0.05) * 5 + Math.cos(zPos * 0.05) * 5;
        height += Math.random() * 2;
        height = Math.max(0, height) * (distanceFromCenter / 30);
      }
      
      mountainPositions.push(xPos, height, zPos);
    }
  }
  
  // 创建索引以便正确渲染三角形
  const indices = [];
  for (let z = 0; z < segmentsZ; z++) {
    for (let x = 0; x < segmentsX; x++) {
      const a = x + (segmentsX + 1) * z;
      const b = x + (segmentsX + 1) * (z + 1);
      const c = (x + 1) + (segmentsX + 1) * (z + 1);
      const d = (x + 1) + (segmentsX + 1) * z;
      
      indices.push(a, b, d);
      indices.push(b, c, d);
    }
  }
  
  mountainGeometry.setIndex(indices);
  mountainGeometry.setAttribute('position', new THREE.Float32BufferAttribute(mountainPositions, 3));
  mountainGeometry.computeVertexNormals();
  
  const mountainMaterial = new THREE.MeshStandardMaterial({
    color: 0xa5d6a7,
    flatShading: true,
    side: THREE.DoubleSide
  });
  
  const mountains = new THREE.Mesh(mountainGeometry, mountainMaterial);
  mountains.position.y = -1; // 稍微下沉一点，与地面融合
  mountains.receiveShadow = true;
  
  scene.add(mountains);
}

// 添加树木和其他装饰物
function addDecorations(scene) {
  // 添加树木
  const treePositions = [
    [-20, 0, -5], [-15, 0, 10], [-8, 0, -15], [8, 0, -15], 
    [15, 0, 10], [20, 0, -5], [-10, 0, 15], [10, 0, 15]
  ];
  
  // 创建树干
  const trunkGeometry = new THREE.CylinderGeometry(0.5, 0.7, 3, 8);
  const trunkMaterial = new THREE.MeshStandardMaterial({ color: 0x795548 });
  
  // 创建树叶
  const leavesGeometry = new THREE.SphereGeometry(2, 8, 8);
  const leavesMaterial = new THREE.MeshStandardMaterial({ color: 0x2e7d32 });
  
  treePositions.forEach(position => {
    const trunk = new THREE.Mesh(trunkGeometry, trunkMaterial);
    trunk.position.set(position[0], position[1] + 1.5, position[2]);
    trunk.castShadow = true;
    trunk.receiveShadow = true;
    scene.add(trunk);
    
    const leaves = new THREE.Mesh(leavesGeometry, leavesMaterial);
    leaves.position.set(position[0], position[1] + 4, position[2]);
    leaves.castShadow = true;
    leaves.receiveShadow = true;
    scene.add(leaves);
  });
}

// 处理颜色值的辅助函数
function parseColor(color) {
  // 如果颜色已经是数字，直接返回
  if (typeof color === 'number') {
    return color;
  }
  
  // 如果是十六进制字符串如 "#FF5500"，转换为数字
  if (typeof color === 'string' && color.startsWith('#')) {
    return parseInt(color.substring(1), 16);
  }
  
  // 默认回退颜色
  return 0x0000FF; // 默认蓝色
}

// 在大学建筑周围添加景观
function addLandscaping(scene, university, buildingGroup) {
  const { width, depth } = university.size;
  const position = university.position;
  
  // 在建筑周围添加草地
  const grassGeometry = new THREE.CircleGeometry(width * 1.5, 32);
  const grassMaterial = new THREE.MeshStandardMaterial({ 
    color: 0x7ec850,
    roughness: 0.8
  });
  const grass = new THREE.Mesh(grassGeometry, grassMaterial);
  grass.rotation.x = -Math.PI / 2;
  grass.position.set(position.x, position.y - university.size.height/2 + 0.01, position.z);
  buildingGroup.add(grass);
  
  // 在建筑周围添加灌木丛
  const bushGeometry = new THREE.SphereGeometry(0.6, 8, 8);
  const bushMaterial = new THREE.MeshStandardMaterial({ 
    color: 0x33691e,
    roughness: 0.9
  });
  
  // 在建筑前方创建半圆形的灌木丛
  const numBushes = 6;
  for (let i = 0; i < numBushes; i++) {
    const angle = Math.PI * (i / (numBushes - 1) - 0.5);
    const bushDistance = width * 1.2;
    
    const bush = new THREE.Mesh(bushGeometry, bushMaterial);
    bush.position.set(
      position.x + Math.sin(angle) * bushDistance,
      position.y - university.size.height/2 + 0.3,
      position.z + Math.cos(angle) * bushDistance
    );
    bush.castShadow = true;
    bush.receiveShadow = true;
    
    // 稍微随机化灌木大小
    const scale = 0.8 + Math.random() * 0.4;
    bush.scale.set(scale, scale, scale);
    
    buildingGroup.add(bush);
  }
  
  // 添加通往门口的路径
  const pathGeometry = new THREE.PlaneGeometry(width * 0.3, depth * 1.2);
  const pathMaterial = new THREE.MeshStandardMaterial({ 
    color: 0xd7ccc8,
    roughness: 0.9
  });
  const path = new THREE.Mesh(pathGeometry, pathMaterial);
  path.rotation.x = -Math.PI / 2;
  path.position.set(
    position.x,
    position.y - university.size.height/2 + 0.02,
    position.z + depth
  );
  buildingGroup.add(path);
  
  // 添加小路标
  const postGeometry = new THREE.CylinderGeometry(0.05, 0.05, 1.2, 8);
  const postMaterial = new THREE.MeshStandardMaterial({ color: 0x5d4037 });
  const post = new THREE.Mesh(postGeometry, postMaterial);
  post.position.set(
    position.x + width * 0.6,
    position.y - university.size.height/2 + 0.6,
    position.z + depth * 0.8
  );
  buildingGroup.add(post);
  
  // 路标上的指示牌
  const signGeometry = new THREE.BoxGeometry(0.8, 0.5, 0.05);
  const signMaterial = new THREE.MeshStandardMaterial({ 
    color: 0xffffff
  });
  const sign = new THREE.Mesh(signGeometry, signMaterial);
  sign.position.set(
    position.x + width * 0.6,
    position.y - university.size.height/2 + 1.2,
    position.z + depth * 0.8
  );
  buildingGroup.add(sign);
  
  // 为指示牌创建文本
  const signCanvas = document.createElement('canvas');
  const signContext = signCanvas.getContext('2d');
  signCanvas.width = 128;
  signCanvas.height = 64;
  
  signContext.fillStyle = '#FFFFFF';
  signContext.fillRect(0, 0, signCanvas.width, signCanvas.height);
  
  signContext.font = 'bold 16px Arial';
  signContext.fillStyle = '#000000';
  signContext.textAlign = 'center';
  signContext.textBaseline = 'middle';
  signContext.fillText('WELCOME', signCanvas.width / 2, signCanvas.height / 3);
  signContext.fillText(university.shortName, signCanvas.width / 2, 2 * signCanvas.height / 3);
  
  const signTexture = new THREE.CanvasTexture(signCanvas);
  const signTextSprite = new THREE.Sprite(new THREE.SpriteMaterial({ map: signTexture }));
  signTextSprite.scale.set(0.8, 0.5, 1);
  signTextSprite.position.set(
    position.x + width * 0.6,
    position.y - university.size.height/2 + 1.2,
    position.z + depth * 0.8 + 0.03
  );
  buildingGroup.add(signTextSprite);
}

// 创建大学建筑
export function createUniversityBuilding(scene, university) {
  const { width, height, depth } = university.size;
  const colorValue = parseColor(university.color);
  
  // 为整个建筑创建一个组
  const buildingGroup = new THREE.Group();
  buildingGroup.userData = { id: university.id, type: 'university' };
  
  // 主体建筑结构，略微调整尺寸
  const buildingGeometry = new THREE.BoxGeometry(width, height, depth);
  const buildingMaterial = new THREE.MeshStandardMaterial({ 
    color: new THREE.Color(colorValue),
    roughness: 0.7
  });
  const building = new THREE.Mesh(buildingGeometry, buildingMaterial);
  building.position.set(
    university.position.x, 
    university.position.y + height/2, 
    university.position.z
  );
  building.castShadow = true;
  building.receiveShadow = true;
  buildingGroup.add(building);
  
  // 添加基座/地基，尺寸略大
  const baseGeometry = new THREE.BoxGeometry(width + 0.5, height/10, depth + 0.5);
  const baseMaterial = new THREE.MeshStandardMaterial({ 
    color: new THREE.Color(0x888888), // 混凝土般的颜色
    roughness: 0.9
  });
  const base = new THREE.Mesh(baseGeometry, baseMaterial);
  base.position.set(
    university.position.x, 
    university.position.y + height/20 - height/2, 
    university.position.z
  );
  base.receiveShadow = true;
  buildingGroup.add(base);
  
  // 在角落添加立柱
  const pillarGeometry = new THREE.CylinderGeometry(0.3, 0.3, height, 8);
  const pillarMaterial = new THREE.MeshStandardMaterial({ 
    color: new THREE.Color(colorValue).multiplyScalar(0.8), // 比主建筑更暗
    roughness: 0.5
  });
  
  // 在四个角落添加立柱
  const pillarPositions = [
    [width/2 - 0.3, -height/2, depth/2 - 0.3],
    [-width/2 + 0.3, -height/2, depth/2 - 0.3],
    [width/2 - 0.3, -height/2, -depth/2 + 0.3],
    [-width/2 + 0.3, -height/2, -depth/2 + 0.3]
  ];
  
  pillarPositions.forEach(pos => {
    const pillar = new THREE.Mesh(pillarGeometry, pillarMaterial);
    pillar.position.set(
      university.position.x + pos[0],
      university.position.y + height/2 + pos[1],
      university.position.z + pos[2]
    );
    pillar.castShadow = true;
    buildingGroup.add(pillar);
  });
  
  // 改进屋顶 - 更有趣的形状
  const roofGeometry = new THREE.ConeGeometry(width/Math.sqrt(2) + 0.5, height/2, 4);
  roofGeometry.rotateY(Math.PI/4); // 与建筑对齐
  const roofMaterial = new THREE.MeshStandardMaterial({ 
    color: new THREE.Color(colorValue).multiplyScalar(1.2), // 稍亮一些
    roughness: 0.6
  });
  const roof = new THREE.Mesh(roofGeometry, roofMaterial);
  roof.position.set(
    university.position.x, 
    university.position.y + height + height/4, 
    university.position.z
  );
  roof.castShadow = true;
  buildingGroup.add(roof);
  
  // 添加带框架的窗户
  const windowMaterial = new THREE.MeshStandardMaterial({ 
    color: 0xbbdefb,
    roughness: 0.2,
    metalness: 0.5
  });
  
  const windowFrameMaterial = new THREE.MeshStandardMaterial({
    color: 0xffffff,
    roughness: 0.5
  });
  
  // 添加前面的多个窗户
  const windowWidth = width * 0.15;
  const windowHeight = height * 0.2;
  const windowDepth = 0.1;
  
  // 前面的窗户 (3x2 网格)
  for (let row = 0; row < 2; row++) {
    for (let col = 0; col < 3; col++) {
      // 窗框
      const frameGeometry = new THREE.BoxGeometry(windowWidth + 0.1, windowHeight + 0.1, windowDepth);
      const frame = new THREE.Mesh(frameGeometry, windowFrameMaterial);
      frame.position.set(
        university.position.x + (col - 1) * windowWidth * 1.5,
        university.position.y + height * 0.1 + row * windowHeight * 1.5,
        university.position.z + depth/2 + 0.01
      );
      buildingGroup.add(frame);
      
      // 窗玻璃
      const glassGeometry = new THREE.BoxGeometry(windowWidth, windowHeight, windowDepth);
      const glass = new THREE.Mesh(glassGeometry, windowMaterial);
      glass.position.set(
        university.position.x + (col - 1) * windowWidth * 1.5,
        university.position.y + height * 0.1 + row * windowHeight * 1.5,
        university.position.z + depth/2 + 0.02
      );
      buildingGroup.add(glass);
    }
  }
  
  // 添加带框的门
  const doorWidth = width * 0.25;
  const doorHeight = height * 0.4;
  
  // 门框
  const doorFrameGeometry = new THREE.BoxGeometry(doorWidth + 0.2, doorHeight + 0.2, depth * 0.1);
  const doorFrame = new THREE.Mesh(doorFrameGeometry, windowFrameMaterial);
  doorFrame.position.set(
    university.position.x,
    university.position.y - height * 0.05,
    university.position.z + depth/2 + 0.01
  );
  buildingGroup.add(doorFrame);
  
  // 门
  const doorGeometry = new THREE.BoxGeometry(doorWidth, doorHeight, depth * 0.1);
  const doorMaterial = new THREE.MeshStandardMaterial({ 
    color: new THREE.Color(colorValue).multiplyScalar(0.9),
    roughness: 0.4
  });
  const door = new THREE.Mesh(doorGeometry, doorMaterial);
  door.position.set(
    university.position.x,
    university.position.y - height * 0.05,
    university.position.z + depth/2 + 0.02
  );
  buildingGroup.add(door);
  
  // 添加门把手
  const knobGeometry = new THREE.SphereGeometry(0.1, 8, 8);
  const knobMaterial = new THREE.MeshStandardMaterial({ 
    color: 0xd4af37, // 金色
    metalness: 0.8,
    roughness: 0.2
  });
  const knob = new THREE.Mesh(knobGeometry, knobMaterial);
  knob.position.set(
    university.position.x + doorWidth/4,
    university.position.y - height * 0.05,
    university.position.z + depth/2 + 0.08
  );
  buildingGroup.add(knob);
  
  // 添加通往门口的台阶
  const stepsMaterial = new THREE.MeshStandardMaterial({ 
    color: 0xcccccc,
    roughness: 0.8
  });
  
  // 三个宽度递增的台阶
  for (let i = 0; i < 3; i++) {
    const stepWidth = doorWidth + (3-i) * 0.2;
    const stepGeometry = new THREE.BoxGeometry(stepWidth, 0.15, 0.6);
    const step = new THREE.Mesh(stepGeometry, stepsMaterial);
    step.position.set(
      university.position.x,
      university.position.y - height/2 - 0.075 - i * 0.15,
      university.position.z + depth/2 + 0.3 + i * 0.3
    );
    step.castShadow = true;
    step.receiveShadow = true;
    buildingGroup.add(step);
  }
  
  // 如果已访问，添加标记
  if (university.visited) {
    const visitedGeometry = new THREE.SphereGeometry(0.5, 16, 16);
    const visitedMaterial = new THREE.MeshStandardMaterial({ color: 0x4caf50 });
    const visitedMarker = new THREE.Mesh(visitedGeometry, visitedMaterial);
    visitedMarker.position.set(
      university.position.x + width/2 - 0.5,
      university.position.y + height/2 + 0.5,
      university.position.z + depth/2 + 0.5
    );
    buildingGroup.add(visitedMarker);
  }
  
  // 创建大学名称标签
  const canvas = document.createElement('canvas');
  const context = canvas.getContext('2d');
  canvas.width = 512;
  canvas.height = 128;
  
  // 创建带有大学颜色的更好看的名称标签
  context.fillStyle = '#FFFFFF';
  context.fillRect(0, 0, canvas.width, canvas.height);
  
  // 添加大学颜色的边框
  const hexColor = '#' + new THREE.Color(colorValue).getHexString();
  context.strokeStyle = hexColor;
  context.lineWidth = 8;
  context.strokeRect(4, 4, canvas.width - 8, canvas.height - 8);
  
  // 添加带有更好排版的大学名称
  context.font = 'bold 40px Arial';
  context.fillStyle = '#000000';
  context.textAlign = 'center';
  context.textBaseline = 'middle';
  context.fillText(university.shortName || university.name, canvas.width / 2, canvas.height / 2);
  
  const texture = new THREE.CanvasTexture(canvas);
  texture.needsUpdate = true;
  
  const spriteMaterial = new THREE.SpriteMaterial({ 
    map: texture,
    transparent: true
  });
  const nameSprite = new THREE.Sprite(spriteMaterial);
  nameSprite.scale.set(12, 3, 1);
  nameSprite.position.set(
    university.position.x,
    university.position.y + height + 3,
    university.position.z
  );
  buildingGroup.add(nameSprite);
  
  // 添加建筑周围的景观
  addLandscaping(scene, university, buildingGroup);
  
  scene.add(buildingGroup);
  return buildingGroup;
}

export function createPlayer(scene) {
  const player = new THREE.Group();
  
  // 头部
  const headGeometry = new THREE.BoxGeometry(1, 1, 1);
  const headMaterial = new THREE.MeshStandardMaterial({ color: 0xffe082 });
  const head = new THREE.Mesh(headGeometry, headMaterial);
  head.position.y = 1.5;
  head.castShadow = true;
  player.add(head);
  
  // 身体
  const bodyGeometry = new THREE.BoxGeometry(0.8, 1, 0.5);
  const bodyMaterial = new THREE.MeshStandardMaterial({ color: 0xffeb3b });
  const body = new THREE.Mesh(bodyGeometry, bodyMaterial);
  body.position.y = 0.5;
  body.castShadow = true;
  player.add(body);
  
  // 左腿
  const leftLegGeometry = new THREE.BoxGeometry(0.4, 0.8, 0.4);
  const legMaterial = new THREE.MeshStandardMaterial({ color: 0x2196f3 });
  const leftLeg = new THREE.Mesh(leftLegGeometry, legMaterial);
  leftLeg.position.set(-0.2, -0.4, 0);
  leftLeg.castShadow = true;
  player.add(leftLeg);
  
  // 右腿
  const rightLegGeometry = new THREE.BoxGeometry(0.4, 0.8, 0.4);
  const rightLeg = new THREE.Mesh(rightLegGeometry, legMaterial);
  rightLeg.position.set(0.2, -0.4, 0);
  rightLeg.castShadow = true;
  player.add(rightLeg);
  
  // 标签 - "YOU"
  const canvas = document.createElement('canvas');
  const context = canvas.getContext('2d');
  canvas.width = 128;
  canvas.height = 64;
  
  context.fillStyle = '#FFFFFF';
  context.strokeStyle = '#000000';
  context.lineWidth = 4;
  context.fillRect(0, 0, canvas.width, canvas.height);
  context.strokeRect(0, 0, canvas.width, canvas.height);
  
  context.font = 'bold 24px Arial';
  context.fillStyle = '#000000';
  context.textAlign = 'center';
  context.textBaseline = 'middle';
  context.fillText('YOU', canvas.width / 2, canvas.height / 2);
  
  const texture = new THREE.CanvasTexture(canvas);
  const spriteMaterial = new THREE.SpriteMaterial({ map: texture });
  const nameSprite = new THREE.Sprite(spriteMaterial);
  nameSprite.scale.set(5, 2.5, 1);
  nameSprite.position.y = 3;
  player.add(nameSprite);
  
  // 添加一个小光源跟随玩家，使玩家在黑暗环境中也可见
  const pointLight = new THREE.PointLight(0xffffff, 0.8, 10);
  pointLight.position.set(0, 2, 0);
  player.add(pointLight);
  
  // 设置初始位置在屏幕中央附近
  player.position.set(0, 0, 0);
  player.name = 'player';
  
  scene.add(player);
  
  return player;
}

// 交互提示 - 改进版本
export function createInteractionPrompt(scene, position, text) {
  // 为文本纹理创建画布
  const canvas = document.createElement('canvas');
  const context = canvas.getContext('2d');
  
  // 设置画布尺寸
  canvas.width = 512;
  canvas.height = 128;
  
  // 创建半透明的白色背景
  context.fillStyle = 'rgba(255, 255, 255, 0.85)';
  context.fillRect(0, 0, canvas.width, canvas.height);
  
  // 添加蓝色边框以提高可见度
  context.strokeStyle = '#2196f3';
  context.lineWidth = 4;
  context.strokeRect(2, 2, canvas.width - 4, canvas.height - 4);
  
  // 设置带阴影的文本样式以提高可读性
  context.font = 'bold 36px Arial';
  context.textAlign = 'center';
  context.textBaseline = 'middle';
  context.shadowColor = 'rgba(0, 0, 0, 0.3)';
  context.shadowBlur = 4;
  context.shadowOffsetX = 2;
  context.shadowOffsetY = 2;
  context.fillStyle = '#1a237e'; // 深蓝色文本
  
  // 绘制文本
  context.fillText(text, canvas.width / 2, canvas.height / 2);
  
  // 使用画布纹理创建精灵
  const texture = new THREE.CanvasTexture(canvas);
  const material = new THREE.SpriteMaterial({ 
    map: texture,
    transparent: true,
    // 关键设置，使标签始终可见
    sizeAttenuation: false,
    depthTest: false
  });
  
  const sprite = new THREE.Sprite(material);
  
  // 设置位置
  sprite.position.copy(position);
  
  // 调整大小以提高可见度（根据需要调整）
  sprite.scale.set(8, 2, 1);
  
  // 添加到场景
  scene.add(sprite);
  
  return sprite;
}