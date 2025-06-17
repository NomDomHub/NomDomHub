--// Cấu hình webhook theo từng nhóm
getgenv().WebhookURLs = {
    ["Dora"] = true,         -- Bật webhook cho nhóm Dora
    ["TuanAnhIos"] = true,   -- Bật webhook cho nhóm Tuấn Anh Ios
    -- Bạn có thể thêm nhóm khác như sau:
    -- ["NhomKhac"] = false, -- Tắt webhook nhóm NhomKhac
}

--// Load script thông báo webhook
loadstring(game:HttpGet("https://raw.githubusercontent.com/TDDuym500/npmc_/refs/heads/main/NotifyBloxFruit.lua"))()
