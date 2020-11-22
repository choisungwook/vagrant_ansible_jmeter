# 상황
* ansible docker 명령어 실행 실패
![](./imgs/failed_docker_build.png)

<br>

# 해결
* vagrant계정을 docker group에 추가
  * vagrant계정이 docker명령어 실행할 수 없음
* Dockerfile 수정
```
- name: create docker group
  group:
    name: docker
    state: present

- name: Add user vagrant to docker group
  user:
    name: vagrant
    groups: docker
    append: yes
  notify:
    - Start docker
```

# 참고자료
* git-issue: https://github.com/ansible/awx/issues/571