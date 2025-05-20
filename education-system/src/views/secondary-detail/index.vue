<template>
  <div class="index container">
    <div class="secondary-title">
      <h2> {{ schoolName }}</h2>
    </div>
    <div class="secondary-detail">
      <div class="detail-left">
        <div class="school-card-container">
          <div class="card shadow-sm border-0">
            <div class="card-body">
              <h2 class="card-title text-primary mb-4">
                {{ schoolName }}
              </h2>

              <div class="ranking-section mb-4 p-3 bg-light rounded">
                <span class="fw-bold">Victoria State Ranking:</span>
                <span class="badge bg-primary ms-2">#{{ getSchoolRanking() }} / 550</span>
              </div>

              <div class="score-table">
                <h5 class="mb-3 text-muted">Median VCE Score:</h5>
                <table class="table table-hover">
                  <tbody>
                    <tr v-for="item in schoolData" :key="item.Year">
                      <td class="year-cell">{{ item.Year }}:</td>
                      <td class="score-cell fw-bold">{{ item.MedianVCEScore }}</td>
                    </tr>
                  </tbody>
                </table>
              </div>
              <p class="text-muted mt-4 small">
                <em>Data based on publicly available school performance statistics.</em>
              </p>
            </div>
          </div>
        </div>


      </div>
      <div class="chart-container">
        <div ref="chart" style="width: 600px; height: 500px;"></div>
      </div>
    </div>
  </div>

</template>

<script setup>
import { useRoute } from 'vue-router';

const route = useRoute();

import { ref, onMounted, onBeforeUnmount } from 'vue';
import * as echarts from 'echarts';

import { secondaryCollegeData, getSchoolData } from "./utils"
const schoolName = ref();
schoolName.value = route.query.name
const chart = ref(null);
let myChart = null;

const schoolData = ref();
schoolData.value = getSchoolData(schoolName.value)
const chartData = {
  years: schoolData.value.map(item=>item.Year),
  MedianVCEScore: schoolData.value.map(item=>item.MedianVCEScore),
};
const getSchoolRanking = () => {
  const creentSchoolData = schoolData.value.find(item=>item.Year == "2024");
  if(creentSchoolData["SchoolRanking"]){
    return creentSchoolData["SchoolRanking"]
  }else{
    return "N/A"
  }
}
const initChart = () => {
  if (!chart.value) return;

  myChart = echarts.init(chart.value);

  const option = {
    title: {
      text: 'Median ATAR Scores Over Time',
      left: 'left'
    },
    tooltip: {
      trigger: 'axis',
      formatter: function(params) {
        console.log(params)
        return `Median ATAR <b>ATAR:${params[0].value}</b> `;
      }
    },
    xAxis: {
      type: 'category',
      boundaryGap: false,
      data: chartData.years,
      axisLabel: {
        color: '#666'
      },
      axisLine: {
        lineStyle: {
          color: '#ddd'
        }
      }
    },
    yAxis: {
      type: 'value',
      min: 20,
      max: 34,
      axisLabel: {
        color: '#666'
      },
      axisLine: {
        show: true,
        lineStyle: {
          color: '#ddd'
        }
      },
      splitLine: {
        lineStyle: {
          color: '#f5f5f5'
        }
      }
    },
    series: [{
      name: 'VCE Score',
      type: 'line',
      data: chartData.MedianVCEScore,
      symbol: 'circle', 
      symbolSize: 8,
      itemStyle: {
        color: '#1890ff'
      },
      lineStyle: {
        width: 3,
        color: '#1890ff'
      },
      areaStyle: {
        color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
          { offset: 0, color: 'rgba(24, 144, 255, 0.3)' },
          { offset: 1, color: 'rgba(24, 144, 255, 0.1)' }
        ])
      },
      label: {
        show: true,
        formatter: '{c}',
        color: '#1890ff',
        fontWeight: 'bold'
      }
    }],
    grid: {
      left: '2%',
      right: '2%',
      bottom: '2%',
      containLabel: true
    }
  };

  myChart.setOption(option);
};

const handleResize = () => {
  myChart?.resize();
};

onMounted(() => {
  initChart();
  window.addEventListener('resize', handleResize);
});

onBeforeUnmount(() => {
  window.removeEventListener('resize', handleResize);
  myChart?.dispose();
});
</script>
<style scoped>
.secondary-detail{
  display: flex;
  background: white;
  border-radius: 8px;
  padding: 20px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
  >div {
    flex: 1
  }
}
.secondary-title{
  font-size: 28px;
  text-align: center;
  padding: 60px 0px;
}
.school-card-container {
  max-width: 500px;
  margin: 2rem auto;
}

.card-title {
  font-size: 1.8rem;
  border-bottom: 2px solid #0d6efd;
  padding-bottom: 0.5rem;
  display: inline-block;
}

.ranking-section {
  font-size: 1.1rem;
}

.year-cell {
  width: 30%;
  color: #6c757d;
}

.score-cell {
  color: #0d6efd;
  font-size: 1.1rem;
}

.table-hover tbody tr:hover {
  background-color: rgba(13, 110, 253, 0.05);
}

.chart-container {
  background: white;
  border-radius: 8px;
  padding: 20px;
  /* box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1); */
}
</style>