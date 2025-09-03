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


def data_or_none(s):
    '''Функция подмешивания NULL в данные (2%)'''
    if r.random() <= 0.02:
        return None
    return s


def duplicated(lst):
    '''Функция генерации дубликатов. В 10% случаев создаёт случайное число дубликатов'''
    cnt = 0
    if r.random() <= 0.1:
        for _ in range((r.randint(1, len(lst) / 100))):
            lst.append(lst[r.randint(0, len(lst) - 1)])
            cnt += 1
    print('Количество созданных дубликатов:', cnt)
    return lst


people_list = duplicated([[fake.first_name(),
     fake.last_name(),
     r.randint(1, 100),
     data_or_none(fake.job()),
     data_or_none(fake.school_name())] for i in range(1000)])

lst_dct = {'people': people_list}

try:
    for key in lst_dct:
        client.insert('de_pet_project.people', lst_dct[key], column_names=['first_name', 'last_name', 'age', 'profession_name', 'education_name'])
    print('Данные в clickhouse успешно записаны')
except ValueError as e:
    print(f'Ошибка записи данных в clickhouse: {e}')
