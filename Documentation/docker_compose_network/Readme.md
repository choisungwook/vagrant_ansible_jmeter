# 1. docker network 생성
```
docker network create jmeter
```

# 2. docker network 확인
```
docker network ls
```

# 3. docker-compose에서 기존 네트워크 사용
* docker-compose에서 external 네트워크 추가
```
networks:
  default:
    external:
      name: jmeter
```


# 참고자료
* 공식문서 번역: https://www.daleseo.com/docker-compose-networks/