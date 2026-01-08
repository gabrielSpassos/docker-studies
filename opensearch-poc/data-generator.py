from datetime import date, timedelta

start_date = date(2025, 1, 1)
categories = ["search", "architecture", "ingestion", "analysis", "mapping", "analytics"]

with open("data.json", "w") as f:
    for i in range(1, 201):
        f.write('{"index":{"_index":"articles"}}\n')
        f.write(
            f'{{"id":{i},"title":"OpenSearch Article {i}",'
            f'"category":"{categories[i % len(categories)]}",'
            f'"content":"This is sample document number {i} used for OpenSearch proof of concept testing.",'
            f'"created_at":"{start_date + timedelta(days=i-1)}"}}\n'
        )
