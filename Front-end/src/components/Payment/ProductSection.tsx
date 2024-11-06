import React from 'react';
import styles from './ProductSection.module.css';
import ShippingSection from './ShippingSection';
import DiscountSection from './DiscountSection';
import OrderSummary from './OrderSummary';
import PaymentMethodSection from './PaymentMethodSection';
interface Product {
  id: number;
  name: string;
  image: string;
  price: number;
  quantity: number;
  variant?: string;
  shipping: {
    method: string;
    cost: number;
    estimatedDelivery: string;
  };
  discount?: {
    id: number;
    name: string;
    amount: number;
    type: 'fixed' | 'percentage';
  };
}

const products: Product[] = [
  {
    id: 1,
    name: 'Dầu gội The Original Hair Shampoo',
    image: 'https://cdn.builder.io/api/v1/image/assets/TEMP/4b5b1dc11ace265e82cba697b6945861f502226766f239a22091c596707b1afe?apiKey=1030477bbfe341728a648dc69cf63b1d&',
    price: 299000,
    quantity: 1,
    shipping: {
        method: 'Standard Shipping',
        cost: 30000,
        estimatedDelivery: '3-5 days'
      },
    discount: {
      id: 1,
      name: 'Mã giảm giá của cửa hàng',
      amount: 10000,
      type: 'fixed',
    },
  },
  {
    id: 1,
    name: 'Dầu gội The Original Hair Shampoo',
    image: 'https://cdn.builder.io/api/v1/image/assets/TEMP/4b5b1dc11ace265e82cba697b6945861f502226766f239a22091c596707b1afe?apiKey=1030477bbfe341728a648dc69cf63b1d&',
    price: 299000,
    quantity: 1,
    shipping: {
        method: 'Standard Shipping',
        cost: 30000,
        estimatedDelivery: '3-5 days'
      },
    discount: {
      id: 1,
      name: 'Mã giảm giá của cửa hàng',
      amount: 10000,
      type: 'fixed',
    },
  },
 
];

const ProductSection: React.FC = () => {
  const totalAmount = products.reduce((sum, product) => sum + (product.price * product.quantity ), 0);
  const totalShippingCost = products.reduce((sum, product) => sum + product.shipping.cost, 0);
  const totalDiscount = products.reduce((sum, product) => sum + (product.discount?.amount || 0), 0);
  return (
    <>
    <section className={styles.productSection}>
      <h2 className={styles.sectionTitle}>Sản phẩm</h2>
      <div className={styles.productHeader}>
        <span>Sản phẩm</span>
        <span>Đơn giá</span>
        <span>Số lượng</span>
        <span>Thành tiền</span>
      </div>
      {products.map((product) => (
        <div key={product.id} className={styles.productItem}>
          <div className={styles.productInfo}>
            <img src={product.image} alt={product.name} className={styles.productImage} />
            <div className={styles.productDetails}>
              <h3 className={styles.productName}>{product.name}</h3>
              {product.variant && <p className={styles.productVariant}>{product.variant}</p>}
              
            </div>
            <div className={styles.productPricing}>
                <span className={styles.productPrice}>{product.price.toLocaleString()} VND</span>
                <span className={styles.productQuantity}>{product.quantity}</span>
                <span className={styles.productTotal}>
              {(product.price * product.quantity).toLocaleString()} VND
            </span>
          </div>
          </div>
          <div className={styles.extraSections}>
            <ShippingSection shipping={product.shipping} />
            <DiscountSection discount={product.discount || null} />
          </div>
        </div>
      ))}
    </section>
    <PaymentMethodSection />
    <OrderSummary totalAmount={totalAmount} totalShippingCost={totalShippingCost} totalDiscount={totalDiscount}/></>
  );
};

export default ProductSection;