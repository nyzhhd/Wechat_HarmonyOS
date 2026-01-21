import { Publish } from '../model/Publish'

@Component
export struct CommentPop {
  @Link show: boolean
  @Link publish: Publish
  onLikeToggle: () => void = () => {}
  onComment: () => void = () => {}

  build() {
    Stack() {
      if (this.show) {
        // 黑色半透明蒙层
        Row()
          .width('100%')
          .height('100%')
          .backgroundColor('#60000000')
          .onClick(() => this.show = false)

        // 白色操作条
        Row({ space: 24 }) {
          Row({ space: 4 }) {
            Image(this.publish.liked ? $r('app.media.ic_zan') : $r('app.media.ic_zan'))
              .width(20)
            Text(this.publish.liked ? '取消' : '赞')
              .fontColor('#666')
          }
          .onClick(() => {
            this.onLikeToggle();
            this.show = false;
          })

          Row({ space: 4 }) {
            Image($r('app.media.ic_comment')).width(20)
            Text('评论').fontColor('#666')
          }
          .onClick(() => {
            this.onComment();
            this.show = false;
          })
        }
        .padding({ left: 24, right: 24, top: 12, bottom: 12 })
        .backgroundColor(Color.White)
        .borderRadius(24)
        .position({ x: '50%', y: '50%' })
        .translate({ x: '-50%', y: '-50%' })
      }
    }
    .width('100%')
    .height('100%')
    .animation({ duration: 200 })
  }
}