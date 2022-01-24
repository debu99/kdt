## Description
Generate CSV file from Prometheus metrics data

## Folder structure
```
/
└───q4
    └───rps.tsv
    └───cpu.tsv
    └───memory.tsv
    └───getcsv.sh
    └───README.md
```

| File/Folder | Usage |
| ------ | ------ |
| [rps.tsv](./rps.tsv) | Requests per second data from ingress  |
| [cpu.tsv](./cpu.tsv) | CPU usage data from ingress  |
| [memory.tsv](./memory.tsv) | Memory usage data from ingress |
| [getcsv.sh](./getcsv.sh) | Bash script file consolidates all three metrics and save into CSV file |
| [README.md](./README.md) | This file |

## Source data
rps.tsv:
```
1642962116	0.34361532322426175
1642962146	9.80742834073476
1642962161	12.931034482758621
```
cpu.tsv:
```
0.004581537642990154
0.011538150989099714
0.01503608660785883
```
memory.tsv
```
75132928
78116864
78311424
```

| File | Format |
| ------ | ------ |
| [rps.tsv](./rps.tsv) | Datatime stamp and values |
| [cpu.tsv](./cpu.tsv) | Value per each datatime stamp |
| [memory.tsv](./memory.tsv) | Value per each datatime stamp |

## How to Run
```
bash getcsv.sh
```

## Result format
result.csv
```
1642962116,0.34361532322426175,0.004581537642990154,75132928
1642962146,9.80742834073476,0.011538150989099714,78116864
1642962161,12.931034482758621,0.01503608660785883,78311424
```

----------------------------------------------



