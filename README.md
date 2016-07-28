# designsource
“淘学网” 本科毕业设计

    塔里木大学“淘学网”是一个类似58同城的二手服务平台。
    
    整体框架使用国产轻量级的Nutz框架，数据库使用MySQL数据库，并用阿里的开源项目Druid作为数据库连接池，实现其强大的监控特性，如统计SQL信息及SQL性能等。
    
    前端使用Bootstrap美化页面并解决响应式需求，使用jQuery及其插件，如zTree(后台权限树)、treeTable、validate、datetimepicker、jBox、summernote等等。
    
    同时，项目集成了Redis缓存、Quartz定时任务及e-mail等功能。
    
    项目特色：
        1. 灵活的权限配置，所有权限在树上实现；
        2. 学生证认证功能，上传学生证照片进行审核，实现类似实名认证功能；
        3. SSO 单点登录，将登录信息存入Redis，并设置失效时间；
        4. 首页搜索提示，点击搜索框，出现商品按照收藏量排序的结果集；
        5. Quartz 定时刷新缓存中搜索框的下拉建议结果集；
        6. 安全可靠的 email 认证功能，email 功能还用于修改密码和忘记密码；
        7. 实现集群，使用 nginx 做负载均衡，后台使用 Quartz 定时“心跳”检测集群；
