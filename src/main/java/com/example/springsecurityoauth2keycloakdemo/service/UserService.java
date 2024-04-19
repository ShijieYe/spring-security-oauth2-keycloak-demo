package com.example.springsecurityoauth2keycloakdemo.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.example.springsecurityoauth2keycloakdemo.entity.User;
import org.springframework.security.core.userdetails.UserDetailsService;

public interface UserService extends IService<User>, UserDetailsService {

}
