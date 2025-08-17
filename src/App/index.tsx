import { createRoot } from 'react-dom/client';
import App from './App';
import './styles/app.scss';

// (Optional) prove DefinePlugin works:
declare const BASE_URL: string; // provided by webpack DefinePlugin
// eslint-disable-next-line no-console
console.log('BASE_URL =', BASE_URL);

const container = document.getElementById('app-container');
if (!container) { throw new Error('Missing #app-container'); }

createRoot(container).render(<App />);
