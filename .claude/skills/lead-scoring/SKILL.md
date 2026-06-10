---
name: lead-scoring
description: Chấm điểm và phân loại lead A/B/C/Reject theo rubric 100 điểm.
triggers:
  - "chấm điểm lead"
  - "score lead"
  - "xếp hạng khách hàng"
  - "prioritize leads"
---

# Lead Scoring Skill

## Rubric 100 điểm

| Tiêu chí | Max | Hướng dẫn |
|---------|-----|-----------|
| ICP Fit | 25 | Ngành + quy mô + decision maker role khớp ICP = 20-25. Partial fit = 10-19. Không fit = 0-9 |
| Trigger Strength | 25 | Hot = 20-25. Warm = 10-19. Cool = 1-9. No trigger = 0 |
| Budget Likelihood | 15 | Vừa funding / quy mô lớn / campaign history rõ = 12-15. Medium = 7-11. Nhỏ/unknown = 1-6 |
| Decision Maker Visibility | 15 | Có tên + role + LinkedIn = 13-15. Chỉ role = 7-12. Chỉ company = 1-6 |
| Timing | 10 | Launch/campaign sắp tới rõ = 8-10. General need = 4-7. No timing signal = 1-3 |
| Ease of Outreach | 10 | LinkedIn + email public = 8-10. LinkedIn only = 5-7. Chỉ website form = 1-4 |

## Tier classification

| Tier | Score | Action |
|------|-------|--------|
| **A** | 80-100 | Full outreach: LinkedIn + email + D+3 + D+7 |
| **B** | 60-79 | LinkedIn message + D+3 follow-up |
| **C** | 40-59 | Giữ trong watchlist, không outreach ngay |
| **Reject** | < 40 | Loại khỏi active list |

## Nguyên tắc

- Score dựa trên evidence, không phải cảm tính
- Không inflate để tier lên cao hơn thực tế
- Document rõ điểm từng tiêu chí để user có thể verify
