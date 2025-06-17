getgenv().WebhookURLs = {
    [Dora] = true,           -- Đặt false để tắt webhook của Dora
    [TuanAnhIos] = true,     -- Đặt false để tắt webhook của Tuấn Anh Ios
    -- Có thể thêm nhiều webhook group khác ở đây
}
loadstring(game:HttpGet("https://raw.githubusercontent.com/TDDuym500/npmc_/refs/heads/main/NotifyBloxFruit.lua"))()
