import { fetchData, parseJSON } from './utils/helpers';

async function main() {
  try {
    const data = await fetchData('https://api.example.com/data');
    console.log(data);
  } catch (err) {
    console.error('Failed:', err);
  }
}

main();
