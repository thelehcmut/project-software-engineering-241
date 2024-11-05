import React from 'react';

import AddressSection from '../components/Payment/AddressSection';
import ProductSection from '../components/Payment/ProductSection';

import styles from '../styles/PaymentPage.module.css';

const PaymentPage: React.FC = () => {
  return (
    <div className={styles.paymentPage}>
      
      <main className={styles.mainContent}>
        <h1 className={styles.pageTitle}>
          <img src="https://cdn.builder.io/api/v1/image/assets/TEMP/a0207c6d2a4732d0426b75f695ecaa47bfb38aa02d5807ffa7ba01e543ff66d4?apiKey=1030477bbfe341728a648dc69cf63b1d&" alt="" className={styles.paymentIcon} />
          Thanh toán
        </h1>
        <AddressSection />
        <ProductSection />
        
        
      </main>
    </div>
  );
};

export default PaymentPage;