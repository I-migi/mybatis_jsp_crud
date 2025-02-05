package com.example.demo.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Service;

import com.example.demo.dto.NewsResponse;

@Service
public class NaverNewsCrawler {
	
	public List<NewsResponse> getMainNews() {
        String url = "https://news.naver.com/?viewType=pc";
        List<NewsResponse> newsList = new ArrayList<>();
        // Jsoup을 사용하여 웹 페이지 가져오기
        try {
			Document doc = Jsoup.connect(url)
			        .userAgent("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36")
			        .get();
			
            Elements newsLinks = doc.select("a.cnf_news._cds_link._editn_link");
            
            for (Element link : newsLinks) {
                String newsTitle = link.text();
                String newsUrl = link.attr("abs:href");
                
                newsList.add(new NewsResponse(newsTitle, newsUrl));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return newsList;

	}
}
