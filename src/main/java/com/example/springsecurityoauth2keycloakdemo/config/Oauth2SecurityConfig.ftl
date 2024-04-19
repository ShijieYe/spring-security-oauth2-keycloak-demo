package com.example.springsecurityoauth2keycloakdemo.config;

import com.example.springsecurityoauth2keycloakdemo.handle.AccessDeniedHandlerImpl;
import com.example.springsecurityoauth2keycloakdemo.handle.AuthenticationEntryPointImpl;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.CsrfConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import static org.springframework.security.web.util.matcher.AntPathRequestMatcher.antMatcher;

@Configuration
@RequiredArgsConstructor
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class Oauth2SecurityConfig {
    /**
     * 认证失败处理类
     */
    private final AuthenticationEntryPointImpl unauthorizedHandler;

    /**
     * 认证失败处理类
     */
    private final AccessDeniedHandlerImpl accessDeniedHandler;

    private final JwtTokenFilter jwtTokenFilter;


    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity httpSecurity) throws Exception {
        return httpSecurity.cors(Customizer.withDefaults())
                .csrf(CsrfConfigurer::disable)
                .exceptionHandling(handling -> {
                    handling.authenticationEntryPoint(unauthorizedHandler);
                    handling.accessDeniedHandler(accessDeniedHandler);
                })
                .authorizeHttpRequests(a -> {
                    // 对于登录login 允许匿名访问
                    a.requestMatchers(antMatcher("/user/login")).permitAll();
                    a.requestMatchers(antMatcher("/user/register")).permitAll();
                    // 除上面外的所有请求全部需要鉴权认证
                    a.anyRequest().authenticated();
                })
                .sessionManagement(session -> session.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
                .addFilterBefore(jwtTokenFilter, UsernamePasswordAuthenticationFilter.class)
                .build();
    }
}
