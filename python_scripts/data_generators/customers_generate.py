from faker import Faker
import pandas as pd
import uuid
import random
from transliterate import translit
from datetime import datetime

#========== Г Е Н Е Р А Ц И Я _ К Л И Е Н Т О В ==========

def generate_customers_data(cl_numb):
    fake_data = Faker("ru_RU")
    e_domains = ['yundex.ru', 'moil.ru', 'gwail.com']

    def trnslt(text):
        return translit(text, 'ru', reversed=True)

    def customer_generation(gender):
        cust_first_name = fake_data.first_name_male() if gender == 'm' else fake_data.first_name_female()
        cust_last_name = fake_data.last_name_male() if gender == 'm' else fake_data.last_name_female()
        cust_email = f"{trnslt(cust_first_name.lower()).replace("'","")}{trnslt(cust_last_name.lower()).replace("'","")}@{random.choice(e_domains)}"
        return {
            "customer_pk" : "cust"+str(uuid.uuid4())[:16].replace("-",""),
            "first_name" : cust_first_name,
            "last_name" : cust_last_name,
            "email" : cust_email,
            "phone_number" : ("+7" + (fake_data.phone_number()[2:].replace(" ", "").replace("(", "").replace(")", "").replace("-", ""))),
            "registration_date" : fake_data.date_between(start_date="-5y", end_date="-8m"),
            "address" : fake_data.address()
        }

    customers = []

    for _ in range(cl_numb):
        gender = random.choice(['m', 'f'])
        customers.append(customer_generation(gender))

    df_customers = pd.DataFrame(customers)
    df_customers.to_csv(f"E:/DBT LEARNING/My_dbt_adv_project/seeds/raw_customers/cust_{datetime.today().strftime('%Y%m%d_%H%M%S')}", index=False)

    customers_ids = [i["customer_pk"] for i in customers]
