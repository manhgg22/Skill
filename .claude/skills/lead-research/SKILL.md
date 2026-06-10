---
name: lead-research
description: Tìm leads tiềm năng từ nguồn public theo ICP. Auto-trigger khi cần tìm khách hàng tiềm năng.
triggers:
  - "tìm lead"
  - "tìm khách hàng"
  - "prospect"
  - "find leads"
  - "research leads"
  - "tìm brand cần video"
---

# Lead Research Skill

## Nguồn public được phép

1. **LinkedIn public** — company page, public profiles
2. **Facebook Page public** — posts, campaigns, about
3. **Website công ty** — about, services, case study, team
4. **Google News / báo chí** — campaign mới, funding, launch
5. **Job boards** — LinkedIn Jobs, ITviec, VietnamWorks (tuyển marketing = signal)
6. **Event/sponsor list** — danh sách sponsor của hội nghị, festival
7. **Brand directory** — Clutch, Agency Vietnam, startup database public
8. **YouTube/TikTok channel public** — xem mức độ đầu tư content

## Quy trình tìm lead

```
1. Nhận ICP (ngành, quy mô, khu vực, decision maker role)
2. Search theo từng nguồn
3. Với mỗi lead tìm được:
   - Verify tên công ty thật
   - Tìm decision maker (CEO/CMO/Head of Marketing) nếu public
   - Tìm trigger (xem trigger-detection skill)
   - Ghi source URL
4. Chỉ đưa vào list nếu có source URL
```

## Fields bắt buộc

| Field | Bắt buộc | Nếu không tìm được |
|-------|----------|-------------------|
| Company | ✅ | Không đưa vào list |
| Website/Source URL | ✅ | Không đưa vào list |
| Industry | ✅ | Ước tính từ website |
| Decision maker | ❌ | Ghi UNKNOWN |
| Email | ❌ | Ghi UNKNOWN |
| Trigger | ✅ | Ghi NO_TRIGGER nếu không tìm thấy |

## Safety Rules

- Không scrape site yêu cầu đăng nhập
- Không dùng thông tin từ data breach
- Không bịa bất kỳ field nào
