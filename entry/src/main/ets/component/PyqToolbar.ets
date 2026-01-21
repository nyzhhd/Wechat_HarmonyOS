import window from '@ohos.window';

@Component
export struct PyqToolbar {
  @Prop cover: string | Resource
  @Prop avatar: string | Resource

  build() {
    Stack() {
      Image(this.cover)
        .width('100%') // 设置图片宽度为100%，使其充满容器
        // .height(300) // 设置图片高度为300px
        .aspectRatio(1.4) // 设置图片的宽高比为2.3:1
        .objectFit(ImageFit.Cover) // 设置图片的填充模式为Cover，确保图片覆盖整个容器


      // 添加背景蒙版渐变层，增强文字可读性
      Row() {
        Blank()
      }
      .width('100%')
      .height(300)
      .position({ x: 0, y: 0 })
      .linearGradient({
        angle: 180,
        colors: [['#00000080', 0.0], ['#00000040', 0.5], ['#00000000', 1.0]]
      })

      Row() {
        Blank()
        Text('')
          .fontColor(Color.White)
          .fontSize(18)
          .fontWeight(600)
          // 添加文字阴影，增强可读性
          .textShadow({
            radius: 4,
            color: Color.Black,
            offsetX: 1,
            offsetY: 1
          })
        Blank()
      }
      .width('100%')
      .position({ x: 0, y: 0 })
      .padding({ top: 12 })

      // 头像和网名容器 - 调整位置和对齐方式
      Row() {
        // 网名显示在头像左侧
        Text('nyzhhd')
          .fontColor(Color.White)
          .fontSize(16)
          .fontWeight(500)
          .textShadow({
            radius: 3,
            color: Color.Black,
            offsetX: 1,
            offsetY: 1
          })
          .margin({ right: 12 })
        
        Image(this.avatar)
          .width(64)
          .aspectRatio(1)
          .borderRadius(8)
          .border({ width: 2, color: Color.White })
      }
      .alignItems(VerticalAlign.Center) // 改为水平居中对齐
      .position({ right: 24, bottom: -1 }) // 头像上移，保留更多封面空间
    }
    .height(300)
  }
}