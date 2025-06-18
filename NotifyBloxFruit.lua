getgenv().WebhookURLs = {
    ["Dora"] = true,           -- Bật webhook của Dora
    ["TuanAnhIos"] = true,     -- Bật webhook của Tuấn Anh Ios
    -- Bạn có thể thêm nhiều webhook khác tại đây
}

loadstring(game:HttpGet("https://raw.githubusercontent.com/TDDuym500/npmc_/refs/heads/main/NotifyBloxFruit.lua"))()
