import { createRoot } from 'react-dom/client';
import App from './App';
import './styles/app.scss';

declare const BASE_URL: string;
console.log('BASE_URL =', BASE_URL);

const container = document.getElementById('app-container');
if (!container) { throw new Error('Missing #app-container'); }

createRoot(container).render(<App />);
