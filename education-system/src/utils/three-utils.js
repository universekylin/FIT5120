// src/utils/three-utils.js - Three.js 工具函数
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
  
  // 添加灯光
  const ambientLight = new THREE.AmbientLight(0xffffff, 0.5);
  scene.add(ambientLight);
  
  const directionalLight = new THREE.DirectionalLight(0xffffff, 0.8);
  directionalLight.position.set(50, 50, 50);
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

// 创建大学建筑
export function createUniversityBuilding(scene, university) {
  const { width, height, depth } = university.size;
  
  // 主体建筑
  const buildingGeometry = new THREE.BoxGeometry(width, height, depth);
  const buildingMaterial = new THREE.MeshStandardMaterial({ 
    color: new THREE.Color(university.color),
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
  
  // 建筑屋顶 - 三角形状
  const roofGeometry = new THREE.ConeGeometry(width/Math.sqrt(2), height/2, 4);
  roofGeometry.rotateY(Math.PI/4); // 旋转使其与建筑对齐
  const roofMaterial = new THREE.MeshStandardMaterial({ 
    color: new THREE.Color(university.color).multiplyScalar(1.2), // 略微更亮
    roughness: 0.6
  });
  const roof = new THREE.Mesh(roofGeometry, roofMaterial);
  roof.position.set(
    university.position.x, 
    university.position.y + height + height/4, 
    university.position.z
  );
  roof.castShadow = true;
  
  // 窗户和门
  const windowMaterial = new THREE.MeshStandardMaterial({ 
    color: 0xbbdefb,
    roughness: 0.2,
    metalness: 0.5
  });
  
  // 左窗户
  const leftWindowGeometry = new THREE.BoxGeometry(width*0.2, height*0.25, depth*0.1);
  const leftWindow = new THREE.Mesh(leftWindowGeometry, windowMaterial);
  leftWindow.position.set(
    university.position.x - width*0.3, 
    university.position.y + height*0.3, 
    university.position.z + depth/2 + 0.01
  );
  
  // 右窗户
  const rightWindowGeometry = new THREE.BoxGeometry(width*0.2, height*0.25, depth*0.1);
  const rightWindow = new THREE.Mesh(rightWindowGeometry, windowMaterial);
  rightWindow.position.set(
    university.position.x + width*0.3, 
    university.position.y + height*0.3, 
    university.position.z + depth/2 + 0.01
  );
  
  // 门
  const doorGeometry = new THREE.BoxGeometry(width*0.25, height*0.4, depth*0.1);
  const door = new THREE.Mesh(doorGeometry, windowMaterial);
  door.position.set(
    university.position.x, 
    university.position.y - height*0.05, 
    university.position.z + depth/2 + 0.01
  );
  
  // 如果已访问，添加标记
  let visitedMarker = null;
  if (university.visited) {
    const visitedGeometry = new THREE.SphereGeometry(0.5, 16, 16);
    const visitedMaterial = new THREE.MeshStandardMaterial({ color: 0x4caf50 });
    visitedMarker = new THREE.Mesh(visitedGeometry, visitedMaterial);
    visitedMarker.position.set(
      university.position.x + width/2 - 0.5, 
      university.position.y + height/2 + 0.5, 
      university.position.z + depth/2 + 0.5
    );
  }
  
  // 创建大学名称标签
  const canvas = document.createElement('canvas');
  const context = canvas.getContext('2d');
  canvas.width = 256;
  canvas.height = 64;
  
  context.fillStyle = '#FFFFFF';
  context.fillRect(0, 0, canvas.width, canvas.height);
  
  context.font = 'bold 24px Arial';
  context.fillStyle = '#000000';
  context.textAlign = 'center';
  context.textBaseline = 'middle';
  context.fillText(university.shortName, canvas.width / 2, canvas.height / 2);
  
  const texture = new THREE.CanvasTexture(canvas);
  texture.needsUpdate = true;
  
  const spriteMaterial = new THREE.SpriteMaterial({ map: texture });
  const nameSprite = new THREE.Sprite(spriteMaterial);
  nameSprite.scale.set(10, 2.5, 1);
  nameSprite.position.set(
    university.position.x,
    university.position.y + height + 2,
    university.position.z
  );
  
  // 为建筑物创建一个组，方便整体操作
  const buildingGroup = new THREE.Group();
  buildingGroup.add(building, roof, leftWindow, rightWindow, door, nameSprite);
  if (visitedMarker) buildingGroup.add(visitedMarker);
  
  buildingGroup.userData = { id: university.id, type: 'university' };
  
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

// 交互提示
export function createInteractionPrompt(scene, position, text) {
  const canvas = document.createElement('canvas');
  const context = canvas.getContext('2d');
  canvas.width = 512;
  canvas.height = 128;
  
  // 背景
  context.fillStyle = '#ffffff';
  context.strokeStyle = '#000000';
  context.lineWidth = 4;
  context.fillRect(0, 0, canvas.width, canvas.height);
  context.strokeRect(0, 0, canvas.width, canvas.height);
  
  // 文本
  context.font = 'bold 32px Arial';
  context.fillStyle = '#000000';
  context.textAlign = 'center';
  context.textBaseline = 'middle';
  context.fillText(text, canvas.width / 2, canvas.height / 2);
  
  // 指向箭头
  context.beginPath();
  context.moveTo(canvas.width / 2 - 20, canvas.height - 4);
  context.lineTo(canvas.width / 2, canvas.height + 20);
  context.lineTo(canvas.width / 2 + 20, canvas.height - 4);
  context.closePath();
  context.fillStyle = '#ffffff';
  context.strokeStyle = '#000000';
  context.fill();
  context.stroke();
  
  const texture = new THREE.CanvasTexture(canvas);
  const material = new THREE.SpriteMaterial({ map: texture });
  const sprite = new THREE.Sprite(material);
  sprite.scale.set(10, 2.5, 1);
  sprite.position.copy(position);
  sprite.position.y += 7; // 位于建筑上方
  
  scene.add(sprite);
  
  return sprite;
}