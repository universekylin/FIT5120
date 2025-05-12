<template>
  <div ref="container" class="three-container">
    <!-- 可选：添加控制按钮 -->
    <div class="controls">
      <button @click="moveObject('up')" class="control-btn up">↑</button>
      <button @click="moveObject('left')" class="control-btn left">←</button>
      <button @click="moveObject('right')" class="control-btn right">→</button>
      <button @click="moveObject('down')" class="control-btn down">↓</button>
      <button @click="resetPosition()" class="control-btn reset">Reset</button>
    </div>
  </div>
</template>

<script setup>
import * as THREE from 'three';
import { ref, onMounted, onBeforeUnmount } from 'vue';
import { gsap } from 'gsap';

const container = ref(null);
let scene, camera, renderer, cube;
let animationId;
const moveSpeed = 0.3; // 移动速度
const keys = {
  ArrowUp: false,
  ArrowDown: false,
  ArrowLeft: false,
  ArrowRight: false,
  w: false,
  a: false,
  s: false,
  d: false
};

// 初始位置
const initialPosition = { x: 0, y: 0, z: 0 };

const init = () => {
  // 创建场景
  scene = new THREE.Scene();
  scene.background = new THREE.Color(0xf0f0f0);
  
  // 创建相机
  camera = new THREE.PerspectiveCamera(
    75,
    container.value.clientWidth / container.value.clientHeight,
    0.1,
    1000
  );
  camera.position.z = 5;
  
  // 创建渲染器
  renderer = new THREE.WebGLRenderer({ antialias: true });
  renderer.setSize(container.value.clientWidth, container.value.clientHeight);
  renderer.setPixelRatio(window.devicePixelRatio);
  container.value.appendChild(renderer.domElement);
  
  // 创建一个立方体
  const geometry = new THREE.BoxGeometry();
  const material = new THREE.MeshStandardMaterial({ 
    color: 0x2194ce,
    metalness: 0.3,
    roughness: 0.4
  });
  cube = new THREE.Mesh(geometry, material);
  scene.add(cube);
  
  // 设置初始位置
  cube.position.set(initialPosition.x, initialPosition.y, initialPosition.z);
  
  // 添加灯光
  const ambientLight = new THREE.AmbientLight(0xffffff, 0.5);
  scene.add(ambientLight);
  
  const directionalLight = new THREE.DirectionalLight(0xffffff, 1);
  directionalLight.position.set(5, 5, 5);
  scene.add(directionalLight);
  
  // 使用 GSAP 制作旋转动画
  gsap.to(cube.rotation, {
    y: Math.PI * 2,
    duration: 8,
    ease: "none",
    repeat: -1
  });
  
  // 添加一个平面作为参考
  const planeGeometry = new THREE.PlaneGeometry(10, 10);
  const planeMaterial = new THREE.MeshStandardMaterial({ 
    color: 0xcccccc,
    side: THREE.DoubleSide
  });
  const plane = new THREE.Mesh(planeGeometry, planeMaterial);
  plane.rotation.x = Math.PI / 2;
  plane.position.y = -1;
  scene.add(plane);
  
  // 添加网格辅助线
  const gridHelper = new THREE.GridHelper(10, 10);
  scene.add(gridHelper);
  
  // 开始渲染循环
  animate();
};

// 处理键盘按下事件
const handleKeyDown = (event) => {
  if (keys.hasOwnProperty(event.key)) {
    keys[event.key] = true;
  }
};

// 处理键盘释放事件
const handleKeyUp = (event) => {
  if (keys.hasOwnProperty(event.key)) {
    keys[event.key] = false;
  }
};

// 移动方块的函数
const moveObject = (direction) => {
  if (!cube) return;
  
  switch (direction) {
    case 'up':
      gsap.to(cube.position, {
        y: cube.position.y + moveSpeed,
        duration: 0.2,
        ease: 'power1.out'
      });
      break;
    case 'down':
      gsap.to(cube.position, {
        y: cube.position.y - moveSpeed,
        duration: 0.2,
        ease: 'power1.out'
      });
      break;
    case 'left':
      gsap.to(cube.position, {
        x: cube.position.x - moveSpeed,
        duration: 0.2,
        ease: 'power1.out'
      });
      break;
    case 'right':
      gsap.to(cube.position, {
        x: cube.position.x + moveSpeed,
        duration: 0.2,
        ease: 'power1.out'
      });
      break;
  }
};

// 重置立方体位置
const resetPosition = () => {
  if (!cube) return;
  
  gsap.to(cube.position, {
    x: initialPosition.x,
    y: initialPosition.y,
    z: initialPosition.z,
    duration: 0.5,
    ease: 'back.out'
  });
};

const animate = () => {
  animationId = requestAnimationFrame(animate);
  
  // 处理键盘输入
  if (cube) {
    if (keys.ArrowUp || keys.w) {
      cube.position.y += moveSpeed * 0.1;
    }
    if (keys.ArrowDown || keys.s) {
      cube.position.y -= moveSpeed * 0.1;
    }
    if (keys.ArrowLeft || keys.a) {
      cube.position.x -= moveSpeed * 0.1;
    }
    if (keys.ArrowRight || keys.d) {
      cube.position.x += moveSpeed * 0.1;
    }
  }
  
  renderer.render(scene, camera);
};

const handleResize = () => {
  if (camera && renderer && container.value) {
    camera.aspect = container.value.clientWidth / container.value.clientHeight;
    camera.updateProjectionMatrix();
    renderer.setSize(container.value.clientWidth, container.value.clientHeight);
  }
};

onMounted(() => {
  init();
  window.addEventListener('resize', handleResize);
  window.addEventListener('keydown', handleKeyDown);
  window.addEventListener('keyup', handleKeyUp);
  
  // 设置焦点到容器，以便能够接收键盘事件
  if (container.value) {
    container.value.setAttribute('tabindex', '0');
    container.value.focus();
  }
});

onBeforeUnmount(() => {
  window.removeEventListener('resize', handleResize);
  window.removeEventListener('keydown', handleKeyDown);
  window.removeEventListener('keyup', handleKeyUp);
  
  cancelAnimationFrame(animationId);
  if (renderer && container.value) {
    container.value.removeChild(renderer.domElement);
  }
  
  // 清理场景
  if (scene) {
    scene.clear();
  }
});
</script>

<style scoped>
.three-container {
  width: 100%;
  height: 400px;
  overflow: hidden;
  border-radius: 8px;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
  position: relative;
  outline: none; /* 移除焦点轮廓 */
}

/* 控制按钮样式 */
.controls {
  position: absolute;
  bottom: 20px;
  right: 20px;
  display: grid;
  grid-template-areas: 
    ". up ."
    "left . right"
    ". down ."
    "reset reset reset";
  grid-gap: 5px;
  z-index: 10;
}

.control-btn {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  background: rgba(0, 0, 0, 0.5);
  color: white;
  border: none;
  font-size: 18px;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: background 0.2s;
}

.control-btn:hover {
  background: rgba(0, 0, 0, 0.7);
}

.control-btn:active {
  transform: scale(0.95);
}

.up { grid-area: up; }
.left { grid-area: left; }
.right { grid-area: right; }
.down { grid-area: down; }
.reset {
  grid-area: reset;
  width: auto;
  border-radius: 20px;
  margin-top: 10px;
  font-size: 14px;
}
</style>