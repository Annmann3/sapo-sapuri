module ApplicationHelper
  def default_mata_tags
    {
      site: 'サポC',
      title: 'カラダの中のビタミンcを可視化して管理するサービス',
      reverse: true,
      charset: 'utf-8',
      description: 'サポCはカラダの中のビタミンcを可視化してサプリメント服用のモチベーションを高めるサービスです。',
      keywords: 'ビタミンc,サプリメント,管理アプリ,サポC',
      canonical: request.original_url,
      separator: '|',
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: asset_pack_url('static/ogp.png'),
        locale: 'ja_JP'
      },
      twitter: {
        card: 'summary_large_image',
        site: '@サポC',
        creator: '@@KurakiAnnmann',
        image: asset_pack_url('static/ogp.png')
      }
    }
  end
end
