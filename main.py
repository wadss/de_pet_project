import os
import random as r
from faker import Faker
import clickhouse_connect
from faker_education import SchoolProvider
from dotenv import load_dotenv

load_dotenv()
USER = os.getenv('CLICKHOUSE_USER')
PASSWORD = os.getenv('CLICKHOUSE_PASSWORD')

fake = Faker('en_US')
fake.add_provider(SchoolProvider)
client = clickhouse_connect.get_client(host='localhost', port=8123, username=USER, password=PASSWORD)

def escape_clickhouse_string(s):
    return s.replace("'", "\\'").replace("\\", "\\\\")

people_list = ', '.join(f"('{fake.first_name()}', '{fake.last_name()}', {r.randint(1, 100)}, {r.randint(1, 50)}, {r.randint(1, 10)})" for i in range(1, 101))
school_list = ', '.join(f"({i}, '{escape_clickhouse_string(fake.school_name())}')" for i in range(1, 11))
prof_list = ', '.join(f"({i}, '{escape_clickhouse_string(fake.job())}')" for i in range(1, 51))
lst_dct = {'people': people_list, 'education': school_list, 'profession': prof_list}

try:
    for key, value in lst_dct.items():
        client.command(f'insert into de_pet_project.{key} format values {value}')
    print('Данные в clickhouse успешно записаны')
except ValueError as e:
    print(f'Ошибка записи данных в clickhouse: {e}')
