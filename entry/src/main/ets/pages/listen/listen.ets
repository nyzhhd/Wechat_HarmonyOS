interface SongItemType {
  img: string // 图像路径
  name: string // 名称
  author: string // 作者
}

@Entry
@ComponentV2
struct Index {
  @Local playIndex: number = -1
  songs: SongItemType[] = [
    {
      img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/0.jpg',
      name: '直到世界的尽头',
      author: 'WANDS',
    },
    {
      img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/1.jpg',
      name: '画',
      author: '赵磊',
    },
    {
      img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/2.jpg',
      name: 'Sweet Dreams',
      author: 'TPaul Sax / Eurythmics',
    },
    {
      img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/3.jpg',
      name: '奢香夫人',
      author: '凤凰传奇',
    },
    {
      img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/4.jpg',
      name: '空心',
      author: '光泽',
    },
    {
      img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/5.jpg',
      name: '反转地球',
      author: '潘玮柏',
    },
    {
      img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/6.jpg',
      name: 'No.9',
      author: 'T-ara',
    },
    {
      img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/7.jpg',
      name: '孤独',
      author: 'G.E.M.邓紫棋',
    },

    {
      img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/8.jpg',
      name: 'Lose Control',
      author: 'Hedley',
    },
    {
      img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/9.jpg',
      name: '倩女幽魂',
      author: '张国荣',
    },
    {
      img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/10.jpg',
      name: '北京北京',
      author: '汪峰',
    },
    {
      img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/11.jpg',
      name: '苦笑',
      author: '汪苏泷',
    },
    {
      img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/12.jpg',
      name: '一生所爱',
      author: '卢冠廷 / 莫文蔚',
    },
    {
      img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/13.jpg',
      name: '月半小夜曲',
      author: '李克勤',
    },
    {
      img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/14.jpg',
      name: 'Rolling in the Deep',
      author: 'Adele',
    },
    {
      img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/15.jpg',
      name: '海阔天空',
      author: 'Beyond',
    }
  ]

  build() {
    Column() {
      Text('听一听')
        .fontColor('#fff')
        .width('100%')
        .padding({top: 30})
        .margin({ bottom: 10 })
      List() {
        ForEach(this.songs, (item: SongItemType, index: number) => {
          ListItem() {
            Row() {
              // 图
              Stack() {
                Image(item.img)
                  .width(80)
                  .border({ radius: 8 })
                  .margin({ right: 10 })
                if (this.playIndex === index) {
                  Image($r('app.media.wave'))
                    .width(24)
                }
              }

              // 字
              Column() {
                Text(item.name)
                  .fontColor('#F3F3F3')
                  .width('100%')
                  .fontWeight(700)
                  .margin({ bottom: 15 })
                Row() {
                  Text('VIP')
                    .fontColor('#9A8E28')
                    .border({ width: 1, color: '#9A8E28', radius: 12 })
                    .padding({
                      left: 5,
                      right: 5,
                      top: 3,
                      bottom: 3
                    })
                    .margin({ right: 10 })
                  Text(item.author)
                    .fontColor('#696969')
                }
                .width('100%')
              }
              .layoutWeight(1)

              // 更多
              Image($r('app.media.ic_more2'))
                .width(24)
                .fillColor('#FEFEFE')
            }
            .width('100%')
            .height(80)
            // .backgroundColor(Color.Pink)
            .margin({ bottom: 10 })
            .onClick(() => {
              this.playIndex = index
            })
          }
        })
      }
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#131313')
    .padding({ left: 10, right: 10 })
    // 扩充组件安全区域
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}