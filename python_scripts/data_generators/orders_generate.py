from faker import Faker
import pandas as pd
import uuid
import random
from datetime import datetime
from glob import glob

#========== Г Е Н Е Р А Ц И Я _ З А К А З О В ==========
fake_data = Faker("ru_RU")

def generate_orders_data(num_orders):
    # Вынужденное действие для получения файлов с исопльзованием *
    customers_files = glob("E:/DBT LEARNING/My_dbt_adv_project/seeds/raw_customers/cust_*.csv")
    products_files = glob("E:/DBT LEARNING/My_dbt_adv_project/seeds/raw_products/prdct_*.csv")
    stores_files = glob("E:/DBT LEARNING/My_dbt_adv_project/seeds/raw_stores/store_*.csv")
        
    customers = pd.read_csv(customers_files[0]) if customers_files else pd.DataFrame()
    products = pd.read_csv(products_files[0]) if products_files else pd.DataFrame()
    stores = pd.read_csv(stores_files[0]) if stores_files else pd.DataFrame()
    
    orders = []
    
    for _ in range(num_orders):
        customer = customers.sample(1).iloc[0]
        product = products.sample(1).iloc[0]
        store = stores.sample(1).iloc[0]

        date_start = pd.to_datetime(customer['registration_date']).date()
        
        orders.append({
            "order_pk": 'ord' + str(uuid.uuid4())[:14].replace("-",""),
            "order_date": fake_data.date_between(
                start_date=date_start, 
                end_date='today'
            ),
            "customer_pk": customer['customer_pk'],
            "product_pk": product['product_pk'],
            "store_pk": store['store_pk'],
            "quantity": random.randint(1, 5),
            "status": random.choice(["Выполнен", "В обработке", "Отменен"])
        })
    
    df_orders = pd.DataFrame(orders)
    df_orders.to_csv(f"E:/DBT LEARNING/My_dbt_adv_project/seeds/raw_orders/ord_{datetime.today().strftime('%Y%m%d_%H%M%S')}.csv", index=False)

    orders_ids = [i["order_pk"] for i in orders]
