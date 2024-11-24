package com.example.coding_test.controller;

import com.example.coding_test.Utill.JdbcUtill;
import com.example.coding_test.dto.LoginDto;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;

@RestController
public class UserController {

    @GetMapping("/")
    public String main() {
        System.out.println("Call / !!!");
        return "Hello!!";
    }

    @GetMapping("/getUserInfo")
    public ResponseEntity<List<Object>> getUserInfo() {
        System.out.println("Call getUserInfo !!!");

        String sql = "SELECT * FROM i_usr_mn";

        try{
            List<Object> result = JdbcUtill.listExecuteQuery(sql);

            // 보안
            if(result.isEmpty()){
                return ResponseEntity.status(404).body(Collections.emptyList());
            }else{
                return ResponseEntity.status(200).body(result);
            }
        }catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(500).body(Collections.singletonList(
                    Collections.singletonList("Unexpected error occurred")));
        }
    }

    @PostMapping("/login")
    public ResponseEntity<Map<String,String>> login (@RequestBody  LoginDto loginDTO ){

        System.out.println("Call Login !!!");

        String sql = "SELECT * FROM i_usr_mn WHERE USR_ID = ? AND  PW = ?";
        try{

            Map<String,String> result = JdbcUtill.mapExecuteQuery(sql, loginDTO.getId(), loginDTO.getPassword());

            if(result.get("USR_ID") != null && result.get("PW") != null){
                return ResponseEntity.status(200).body(result);
            }else {
                return ResponseEntity.status(404).body(null);
            }

        }catch (Exception e){
            e.printStackTrace();
            return ResponseEntity.status(500).body(null);
        }
    }


    @PostMapping("/signUp")
    public ResponseEntity<Map<String,String>> signUp (@RequestBody LoginDto loginDto){
        System.out.println("signUp Call!!");
        String col = "(USR_ID, PW , NAME , EMAIL)";
        String val = "(\"" + loginDto.getId() +"\" , \"" + loginDto.getPassword() + "\" , \"TEST\", \"test@test.ccc2\")";
        String sql = "INSERT INTO i_usr_mn " +col + "VALUES" + val;

        int result = JdbcUtill.intExecuteQuery(sql);

        if(result > 1){
            return ResponseEntity.status(200).body(null);
        }else {
            return ResponseEntity.status(404).body(null);
        }

    };
}