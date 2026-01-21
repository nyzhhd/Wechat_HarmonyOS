@Component
export struct GridNine {
  @Prop pics: (string | Resource)[]

  build() {
    Grid() {
      if (this.pics && this.pics.length > 0) {
        ForEach(this.pics, (pic: string | Resource) => {
          GridItem() {
            Image(pic)
              .width('100%')
              .aspectRatio(1)
              .borderRadius(4)
              .objectFit(ImageFit.Cover)
          }
        }, (pic: string | Resource) => JSON.stringify(pic))
      }
    }
    .columnsTemplate(this.pics.length === 1 ? '1fr' :
      this.pics.length === 4 ? '1fr 1fr' :
        '1fr 1fr 1fr')
    .rowsGap(4)
    .columnsGap(4)
    .width(this.pics.length === 1 ? '60%' : '100%')
  }
}