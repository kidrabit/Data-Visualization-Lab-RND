const fs = require('fs');
const path = require('path');

const voronoi = JSON.parse(fs.readFileSync(path.resolve(__dirname, '../data/kr_village_voronoi_intersection_old.json')));

const result = {
  type: 'FeatureCollection',
  features: []
};
for (let i = 0; i < voronoi.features.length; i++) {
  voronoi.features[i].properties.emdlid = i;
}

const output = JSON.stringify(voronoi);
fs.writeFile(path.resolve(__dirname, '../data/kr_village_voronoi_intersection.json'), output, 'utf8', (err) => {
  if (err) throw err;
  console.log('output:', voronoi.features.length);
});
