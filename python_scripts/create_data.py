# ===== СКРИПТ ДЛЯ ЗАПУСКА ГЕНЕРАЦИИ ВСЕХ НЕОБХОДИМЫХ ДАННЫХ ====

from data_generators.customers_generate import generate_customers_data # -- генератор информации о клиентах
from data_generators.suppliers_generate import generate_suppliers_data # -- генератор информации о производителях
from data_generators.products_geterate import generate_products_data # -- генератор информации о продукции
from data_generators.stores_generate import generate_stores_data # -- генератор информации о магазиных
from data_generators.orders_generate import generate_orders_data # -- генератор информации о заказах

# generate_customers_data(10)
# generate_products_data() # -- запуск при необходимости(данные сейчас одни и те же)
# generate_suppliers_data() # -- запуск при необходимости(данные сейчас одни и те же)
# generate_stores_data(5)
generate_orders_data(40) # -- производится отдельно после генерации других данных