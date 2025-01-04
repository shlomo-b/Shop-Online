import React, { useState, useEffect } from 'react';
import axios from 'axios';
import { ShoppingBag, Star, Truck, Trash2 } from 'lucide-react';

// Get the API URL from environment variables with a fallback
const API_URL = process.env.REACT_APP_API_URL || 'http://localhost:5050';

function Home({ isAuthenticated }) {
  const [products, setProducts] = useState([]);

  useEffect(() => {
    fetchProducts();
  }, []);

  const fetchProducts = async () => {
    try {
      const response = await axios.get(`${API_URL}/api/products`);
      setProducts(response.data);
    } catch (error) {
      console.error('Error fetching products:', error);
      // You might want to add some error state handling here
      setProducts([]);
    }
  };

  const handleDelete = async (productId) => {
    try {
      await axios.delete(`${API_URL}/api/products/${productId}`);
      fetchProducts();
    } catch (error) {
      console.error('Error deleting product:', error);
      // You might want to add some error feedback to the user here
    }
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-gray-50 to-gray-100 dark:from-gray-900 dark:to-gray-800">
      {/* Hero Section */}
      <div className="max-w-7xl mx-auto py-16 px-4 sm:px-6 lg:px-8">
        <div className="text-center">
          <h1 className="text-4xl font-extrabold text-gray-900 dark:text-white sm:text-5xl md:text-6xl">
            Welcome to stav React Shop
          </h1>
          <p className="mt-3 max-w-md mx-auto text-base text-gray-500 dark:text-gray-300 sm:text-lg md:mt-5 md:text-xl md:max-w-3xl">
            Discover our collection of high-quality products at amazing prices.
          </p>
        </div>

        {/* Features */}
        <div className="mt-16">
          <div className="grid grid-cols-1 gap-8 sm:grid-cols-2 lg:grid-cols-3">
            <div className="pt-6">
              <div className="flow-root bg-white dark:bg-gray-800 rounded-lg px-6 pb-8">
                <div className="-mt-6">
                  <div>
                    <span className="inline-flex items-center justify-center p-3 bg-indigo-500 rounded-md shadow-lg">
                      <ShoppingBag className="h-6 w-6 text-white" />
                    </span>
                  </div>
                  <h3 className="mt-8 text-lg font-medium text-gray-900 dark:text-white tracking-tight">Quality Products</h3>
                  <p className="mt-5 text-base text-gray-500 dark:text-gray-400">
                    All our products are carefully selected to ensure the highest quality.
                  </p>
                </div>
              </div>
            </div>

            <div className="pt-6">
              <div className="flow-root bg-white dark:bg-gray-800 rounded-lg px-6 pb-8">
                <div className="-mt-6">
                  <div>
                    <span className="inline-flex items-center justify-center p-3 bg-indigo-500 rounded-md shadow-lg">
                      <Truck className="h-6 w-6 text-white" />
                    </span>
                  </div>
                  <h3 className="mt-8 text-lg font-medium text-gray-900 dark:text-white tracking-tight">Fast Delivery</h3>
                  <p className="mt-5 text-base text-gray-500 dark:text-gray-400">
                    Quick and reliable shipping to your doorstep.
                  </p>
                </div>
              </div>
            </div>

            <div className="pt-6">
              <div className="flow-root bg-white dark:bg-gray-800 rounded-lg px-6 pb-8">
                <div className="-mt-6">
                  <div>
                    <span className="inline-flex items-center justify-center p-3 bg-indigo-500 rounded-md shadow-lg">
                      <Star className="h-6 w-6 text-white" />
                    </span>
                  </div>
                  <h3 className="mt-8 text-lg font-medium text-gray-900 dark:text-white tracking-tight">Best Prices</h3>
                  <p className="mt-5 text-base text-gray-500 dark:text-gray-400">
                    Competitive prices on all our products.
                  </p>
                </div>
              </div>
            </div>
          </div>
        </div>

        {/* Products Grid */}
        <div className="mt-16">
          <h2 className="text-3xl font-extrabold text-gray-900 dark:text-white mb-8">Our Products</h2>
          <div className="grid grid-cols-1 gap-6 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4">
            {products.map((product) => (
              <div key={product._id} className="bg-white dark:bg-gray-800 rounded-lg shadow-lg overflow-hidden">
                <div className="p-6">
                  <h3 className="text-lg font-semibold text-gray-900 dark:text-white mb-2">
                    {product.name}
                  </h3>
                  <p className="text-gray-500 dark:text-gray-400 mb-4">
                    {product.description}
                  </p>
                  <div className="flex items-center justify-between">
                    <span className="text-2xl font-bold text-indigo-600 dark:text-indigo-400">
                      ${product.price.toFixed(2)}
                    </span>
                    {isAuthenticated && (
                      <button
                        onClick={() => handleDelete(product._id)}
                        className="p-2 text-red-600 hover:text-red-800 dark:text-red-400 dark:hover:text-red-300 transition-colors"
                        aria-label="Delete product"
                      >
                        <Trash2 className="h-5 w-5" />
                      </button>
                    )}
                  </div>
                </div>
              </div>
            ))}
          </div>
        </div>
      </div>
    </div>
  );
}

export default Home;