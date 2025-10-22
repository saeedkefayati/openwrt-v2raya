# V2rayA

this is repository for all action in V2rayA service

[![AGPL License](https://img.shields.io/badge/License-AGPL%20v3-blue.svg)](https://choosealicense.com/licenses/agpl-3.0)
![GitHub last commit](https://img.shields.io/github/last-commit/saeedkefayati/openwrt-V2rayA)
![GitHub top language](https://img.shields.io/github/languages/top/saeedkefayati/openwrt-V2rayA)
![GitHub repo size](https://img.shields.io/github/repo-size/saeedkefayati/openwrt-V2rayA)
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/saeedkefayati/openwrt-V2rayA)


<figure>
  <pre role="img" aria-label="ASCII BANNER" style="text-align:center; font-size:0.75rem;">
.---------------------------------------.
|                                       |
|                                       |
|   _____ ___ _____ _____ __ __ _____   |
|  |  |  |_  | __  |  _  |  |  |  _  |  |
|  |  |  |  _|    -|     |_   _|     |  |
|   \___/|___|__|__|__|__| |_| |__|__|  |
|                                       |
|                                       |
'---------------------------------------'
  </pre>
</figure>

<br/>


## Smart Installation (Recommend)

1. Install Dependencies<br/>
```bash
  opkg install git git-http
```

<br/>

2. Usage with this command<br/>
- Github:
```bash
sh <(wget -qO- https://raw.githubusercontent.com/saeedkefayati/openwrt-V2rayA/main/install.sh)
```

- Githack:
```bash
sh <(wget -qO- https://raw.githack.com/saeedkefayati/openwrt-V2rayA/main/install.sh)
```

- jsdelivr CDN:
```bash
sh <(wget -qO- https://cdn.jsdelivr.net/gh/saeedkefayati/openwrt-V2rayA@main/install.sh)
```

- statically CDN
```bash
sh <(wget -qO- https://cdn.statically.io/gh/saeedkefayati/openwrt-V2rayA/main/install.sh)
```

<br/>

## Iran Direct Setting (should use after using option 4 in menu)

# General Settings

| Setting | Value |
|----------|--------|
| Transparent Proxy/System Proxy | On: Traffic Splitting Mode is the Same as the Rule Port |
| Transparent Proxy/System Proxy | IP Forward |
| Transparent Proxy/System Proxy Implementation | tproxy |
| Traffic Splitting Mode of Rule Port | RoutingA |
| Prevent DNS Spoofing | Forward DNS Request |
| Special Mode | Off |
| TCPFastOpen | Keep Default |
| Sniffing | Http + TLS + Quic |
| Multiplex | Off |
| Automatically Update Subscriptions | Update Subscriptions Regularly (Unit: hour) |
| Automatically Update Subscriptions | 720 |
| Mode when Update Subscriptions and GFWList | Follows Transparent Proxy/System Proxy |

# Custom Rules
> After checking settings, go to **“Setting → RoutingA”** tab.  
> Copy **ALL** the rules below and paste them into the **“Custom Rules”** box:

```bash
domain(geosite:category-ads-all) -> block
domain(geosite:ads) -> block
domain(geosite:nsfw) -> block
domain(geosite:category-porn) -> block
domain(geosite:cavporn) -> block
domain(geosite:54647) -> block
domain(geosite:anon-v) -> block
domain(geosite:avmoo) -> block
domain(geosite:bdsmhub) -> block
domain(geosite:bilibili2) -> block
domain(geosite:boboporn) -> block
domain(geosite:bongacams) -> block
domain(geosite:brazzers) -> block
domain(geosite:camwhores) -> block
domain(geosite:chatwhores) -> block
domain(geosite:clips4sale) -> block
domain(geosite:coomer) -> block
domain(geosite:cuinc) -> block
domain(geosite:digitalplayground) -> block
domain(geosite:dmm-porn) -> block
domain(geosite:hentaivn) -> block
domain(geosite:hooligapps) -> block
domain(geosite:japonx) -> block
domain(geosite:javbus) -> block
domain(geosite:javcc) -> block
domain(geosite:javdb) -> block
domain(geosite:javwide) -> block
domain(geosite:johren) -> block
domain(geosite:justav) -> block
domain(geosite:konachan) -> block
domain(geosite:lethalhardcore) -> block
domain(geosite:lisiku) -> block
domain(geosite:mindgeek) -> block
domain(geosite:mindgeek-porn) -> block
domain(geosite:missav) -> block
domain(geosite:moxing) -> block
domain(geosite:mydirtyhobby) -> block
domain(geosite:netflav) -> block
domain(geosite:nudevista) -> block
domain(geosite:nutaku) -> block
domain(geosite:playboy) -> block
domain(geosite:pornhub) -> block
domain(geosite:pornpros) -> block
ip(geoip:malware) -> block
domain(geosite:malware) -> block
ip(geoip:phishing) -> block
domain(geosite:phishing) -> block
domain(geosite:cryptominers) -> block
domain(geosite:category-public-tracker) -> block
ip(geoip:private) -> direct
domain(geosite:private) -> direct
domain(geosite:ir) -> direct
ip(geoip:ir) -> direct
domain(geosite:category-ir) -> direct
domain(geosite:category-bank-ir) -> direct
domain(geosite:category-bourse-ir) -> direct
domain(geosite:category-education-ir) -> direct
domain(geosite:category-forums-ir) -> direct
domain(geosite:category-gov-ir) -> direct
domain(geosite:category-insurance-ir) -> direct
domain(geosite:category-media-ir) -> direct
domain(geosite:category-news-ir) -> direct
domain(geosite:category-payment-ir) -> direct
domain(geosite:category-scholar-ir) -> direct
domain(geosite:category-social-media-ir) -> direct
domain(geosite:category-tech-ir) -> direct
domain(geosite:category-travel-ir) -> direct
domain(geosite:category-dev) -> proxy
default: proxy
```

## Special Thanks  

- [OpenWrt](https://github.com/openwrt)
- [V2rayA](https://github.com/V2rayA/V2rayA-openwrt)
- [Iran-v2ray-rules](https://github.com/Chocolate4U/Iran-v2ray-rules)
