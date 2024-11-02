import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import './styles/global.css'
import {
  createBrowserRouter,
  RouterProvider,
} from "react-router-dom";
import RegisterPage from './pages/register.tsx';
import Header from './components/layout/header.tsx';
import LoginPage from './pages/login.tsx';
import ForgotPassWordPage from './pages/forgotpassword.tsx';
import HomePage from './pages/home.tsx';
import StorePage from './pages/store.tsx';
import StoreManagement from './pages/managerStore.tsx';
import StoreDeletion from './pages/deleteStore.tsx';
const router = createBrowserRouter([
  {
    path: "/",
    element: <>
      <Header
        isLogin={false}
      />
      <HomePage />
    </>
  },
  {
    path: "/login",
    element:
      <>
        <Header
          isLogin={false}
        />
        <LoginPage />
      </>
  },
  {
    path: "/register",
    element: <>
      <Header
        isLogin={false}
      />
      <RegisterPage />
    </>

  },
  {
    path: "/forgot-password",
    element: <>
      <Header
        isLogin={false}
      />
      <ForgotPassWordPage />
    </>
  },
  {
    path: "/product/:id",
    element: <>
      <Header
        isLogin={true}
      />
    </>
  }
  ,
  {
    path: "/store",
    element: <>
      <Header
        isLogin={true}
      />
      <StorePage />
    </>
  }
  , {
    path: "/store/create",
    element: <>
      <Header
        isLogin={true}
      />
      <StorePage />
    </>
  },
  {
    path: "/store/manage",
    element: <>
      <Header
        isLogin={true}
      />
      <StoreManagement />
    </>
  },
  {
    path: "/store/delete",
    element: <>
      <Header
        isLogin={true}
      />
      <StoreDeletion />
    </>
  }

]);


createRoot(document.getElementById('root')!).render(
  <StrictMode>
    <RouterProvider router={router} />
  </StrictMode>,
)