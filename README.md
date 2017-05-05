# FMPageRouter
FMPageRouter作为一款页面路由框架，将采用restful风格来实现页面的路由功能。其restful匹配解决方案，将参考RestKit的方案来实现。在实现的过程中，我们对于注册页面的机制将放在+(void)load支持的自定义函数中实现。
对于支持的协议，我们将采用app互调方案，同时支持http&https协议，但对http&https的支持将仅在协议配置时指定域名(或主机)的情况下适用。
