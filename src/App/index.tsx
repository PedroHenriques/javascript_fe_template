import { createRoot } from 'react-dom/client';
import { store } from '@app/store/store';
import { Provider } from 'react-redux';
import App from '@app/components/App';

declare const BASE_URL: string;
console.log('BASE_URL =', BASE_URL);
console.log('REACT_APP_ENV =', process.env.REACT_APP_ENV);

const container = document.getElementById('app-container');
if (!container) { throw new Error('Missing #app-container'); }

const root = createRoot(container);
root.render(
  <Provider store={store}>
    <App />
  </Provider>,
);
