# ===== СКРИПТ ДЛЯ ЗАПУСКА ГЕНЕРАЦИИ ВСЕХ НЕОБХОДИМЫХ ДАННЫХ ====

from data_generators.customers_generate import generate_customers_data # -- генератор информации о клиентах
from data_generators.suppliers_generate import generate_suppliers_data # -- генератор информации о производителях
from data_generators.products_geterate import generate_products_data # -- генератор информации о продукции

generate_customers_data(10)
# generate_products_data() # -- запуск при необходимости(данные сейчас одни и те же)
# generate_suppliers_data() # -- запуск при необходимости(данные сейчас одни и те же)