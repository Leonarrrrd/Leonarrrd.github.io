package com.example.demo.service;

import com.example.demo.entity.WeightLog;
import com.example.demo.repository.WeightLogRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;

@Service
public class WeightLogService {

    @Autowired
    private WeightLogRepository weightLogRepository;

    public void saveWeight(Long userId, LocalDate date, Float weight) {
        WeightLog log = weightLogRepository.findByUserIdAndDate(userId, date)
                .orElse(new WeightLog());
        log.setUserId(userId);
        log.setDate(date);
        log.setWeight(weight);
        weightLogRepository.save(log);
    }

    public List<WeightLog> getWeightLogsByMonth(Long userId, int year, int month) {
        LocalDate start = LocalDate.of(year, month, 1);
        LocalDate end = start.withDayOfMonth(start.lengthOfMonth());
        return weightLogRepository.findByUserIdAndDateBetweenOrderByDateAsc(userId, start, end);
    }

    public List<WeightLog> getAllWeightLogs(Long userId) {
        return weightLogRepository.findAllByUserIdOrderByDateAsc(userId);
    }
}