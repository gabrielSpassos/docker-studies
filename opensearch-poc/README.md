# Open Search POC

### Usage

* Start container
```bash
docker compose up
```

* Test container
```bash
curl -k -u admin:9scZP@Fox6B5fRIM https://localhost:9200
```

* Create content
```bash
python3 data-generator.py
```

* Create index
```bash
curl -k -u admin:9scZP@Fox6B5fRIM \
  -X PUT "https://localhost:9200/articles" \
  -H 'Content-Type: application/json' \
  -d '
{
  "settings": {
    "number_of_shards": 1,
    "number_of_replicas": 0
  },
  "mappings": {
    "properties": {
      "id":    { "type": "integer" },
      "title": { "type": "text" },
      "body":  { "type": "text" }
    }
  }
}
'

{"acknowledged":true,"shards_acknowledged":true,"index":"articles"}
```

* Bulk insert
```bash
curl -k -u admin:9scZP@Fox6B5fRIM \
  -X PUT "https://localhost:9200/_bulk" \
  -H 'Content-Type: application/json' \
  --data-binary @data.json
```

* Query
```bash
curl -k -u admin:9scZP@Fox6B5fRIM \
  -X GET "https://localhost:9200/articles/_search" \
  -H 'Content-Type: application/json' \
  -d'
{
  "query": {
    "match": {"body":"guide"}
  }
}
'
{"took":596,"timed_out":false,"_shards":{"total":1,"successful":1,"skipped":0,"failed":0},"hits":{"total":{"value":0,"relation":"eq"},"max_score":null,"hits":[]}}
```

* Aggregations
```bash
curl -X GET "http://localhost:9200/articles/_search" \
  -H 'Content-Type: application/json' \
  -d'
{
  "size": 0,
  "aggs": {
    "by_title": {
      "terms": {"field": "title.keyword"}
    }
  }
}
'
```

* Autosuggest
```bash
curl -X PUT "http://localhost:9200/suggest" \
  -H 'Content-Type: application/json' \
  -d'
{
  "mappings": {
    "properties": {
      "suggest": {
        "type": "completion"
      }
    }
  }
}
'

curl -X POST "http://localhost:9200/suggest/_doc/1" \
  -H 'Content-Type: application/json' \
  -d'
{
  "suggest": "OpenSearch tutorial"
}
'

curl -X GET "http://localhost:9200/suggest/_search" \
  -H 'Content-Type: application/json' \
  -d'
{
  "suggest": {
    "text": "Open",
    "simple_phrase": {
      "completion": {
        "field": "suggest"
      }
    }
  }
}
'

```