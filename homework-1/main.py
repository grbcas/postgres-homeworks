"""Скрипт для заполнения данными таблиц в БД Postgres."""
import psycopg2
from pathlib import Path

employees_data_csv_path = Path(Path(__file__).parent, 'north_data', 'employees_data.csv')
customers_data_csv_path = Path(Path(__file__).parent, 'north_data', 'customers_data.csv')
orders_data_csv_path = Path(Path(__file__).parent, 'north_data', 'orders_data.csv')

print()

conn = psycopg2.connect(
    host="localhost",
    database="north",
    user="postgres",
    password="pgpwd1234"
)

with conn.cursor() as cur:


    with open(employees_data_csv_path, 'r', encoding='utf8') as f_csv:
        copy_from = """
        COPY employees 
        FROM STDIN
        WITH (
            FORMAT CSV,
            DELIMITER ',',
            HEADER
        );
        """
        cur.copy_expert(copy_from, f_csv)
        conn.commit()

    with open(customers_data_csv_path, 'r', encoding='utf8') as f_csv:
        copy_from = """
        COPY customers 
        FROM STDIN
        WITH (
            FORMAT CSV,
            DELIMITER ',',
            HEADER
        );
        """
        cur.copy_expert(copy_from, f_csv)
        conn.commit()

    with open(orders_data_csv_path, 'r', encoding='utf8') as f_csv:
        copy_from = """
        COPY orders 
        FROM STDIN
        WITH (
            FORMAT CSV,
            DELIMITER ',',
            HEADER
        );
        """
        cur.copy_expert(copy_from, f_csv)
        conn.commit()
