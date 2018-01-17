<?php

namespace Drupal\recipes_custom\Plugin\Block;

use drunomics\ServiceUtils\Core\Routing\CurrentRouteMatchTrait;
use Drupal\contextual_views\Plugin\Block\ContextualViewsBlock;
use Drupal\Core\Cache\Cache;

/**
 * Provides a block that customize the block provided by views.
 *
 * @Block(
 *  id = "views_block:recipes_by_category-contextual_views_block_1",
 *  admin_label = @Translation("Recipes: More by category"),
 * )
 */
class RecipesMoreByCategory extends ContextualViewsBlock {

  use CurrentRouteMatchTrait;

  /**
   * {@inheritdoc}
   */
  public function getCacheTags() {
    return Cache::mergeTags(parent::getCacheTags(), ['node_list']);
  }

  /**
   * {@inheritdoc}
   */
  public function build() {
    $node = $this->getCurrentRouteMatch()->getParameter('node');

    if (!$node || !$node->field_category) {
      return;
    }

    $category_id = NULL;
    if ($item = $node->field_category->first()) {
      $category_id = $item->entity->id();
    }

    $args = [
      $category_id,
    ];
    $this->view->setArguments($args);

    return parent::build();
  }

}
