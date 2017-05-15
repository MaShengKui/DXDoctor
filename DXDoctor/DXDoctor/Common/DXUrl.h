//
//  DXUrl.h
//  DXDoctor
//
//  Created by Mask on 15/9/24.
//  Copyright (c) 2015年 Mask. All rights reserved.
//

#ifndef DXDoctor_DXUrl_h
#define DXDoctor_DXUrl_h

//1.首页

//1.1对症找药
#define k_FINDDRUGS_URL  @"http://drugs.dxy.cn/api/v2/disease-keywords?ac=d5424fa6-adff-4b0a-8917-4264daf4a348&vc=4.0.7&mc=fffffffff3f119d7d0a4c830210b76d7"

//1.2家庭药箱
#define k_FAMILYDRUGS_URL  @"http://dxy.com/app/i/search/words/list?items_per_page=10&page_index=1"
//分享
#define k_SHARE_RUL @"http://www.dxy.cn/topic/event/index.html"
//2.健康科普（最新资讯/健康专题）
#define k_NEWINFO_URL @"http://dxy.com/app/i/columns/%@/list?page_index=%d&items_per_page=10&order=publishTime"

//2.1健康科普（真相）
#define k_TRUTH_URL @"http://dxy.com/app/i/columns/truth/article/list?ac=1d6c96d5-9a53-4fe1-9537-85a33de916f1&items_per_page=10&page_index=%d"

//2.2健康科普（母婴 肿瘤 慢病 营养）
#define  k_OTHER_URL @"http://dxy.com/app/i/columns/article/list?channel_id=%@&items_per_page=10&order=publishTime&page_index=%d"

//2.2.1健康科普（详情页面）
#define k_ALLDETAIL_URL @"http://dxy.com/app/i/columns/article/single?id=%@"

//健康科普（健康专题）详细一级
#define K_HEATH_DETAIL_URL @"http://dxy.com/app/i/columns/article/list?page_index=1&items_per_page=10&order=publishTime&special_id=%@"

//3.0 搜索
#define k_SEARCHING_URL @"http://dxy.com/app/i/med/drugdiseasecheck?q=%@"

//3.1搜索一级页面 ----->相关疾病
#define k_SEARCHING_RELATEDISEASE_URL @"http://drugs.dxy.cn/api/v2/search"

//3.2 -------->相关健康问答
#define k_SEARCHING_HEALTHANSWER_URL @"http://dxy.com/app/i/faq/qa/related?ac=1d6c96d5-9a53-4fe1-9537-85a33de916f1&items_per_page=1000&q=%@"
//3.3---------->相关科普文章
#define k_SEARCHING_RELATEARTICLE_URL @"http://dxy.com/app/i/columns/article/related?items_per_page=10&page_index=1&q=%@"
//3.3.1----------->更多健康问题解答
#define  k_MOREHEALET_QUESTIONANSWER_URL @"http://dxy.com/app/i/faq/qa/related/single?items_per_page=1000&add_br=true&article_id=%@&q=%@"


//4.0更多
//4.1 健康测评
#define k_HEALTHTEST_URL @"http://drugs.dxy.cn/api/v2/page-info-list?u=&mc=ffffffffe7ee5e97e1bc896d62cce401&page=1&ac=d5424fa6-adff-4b0a-8917-4264daf4a348&bv=2014&vc=4.0.7&vs=4.4.4"
#endif
