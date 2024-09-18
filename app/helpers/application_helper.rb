module ApplicationHelper
  def toastify_flash
    flash.each_with_object([]) do |(type, message), flash_messages|
      flash_messages << "Toastify({
        text: '#{message}',
        duration: 3000,
        close: true,
        gravity: 'top',
        position: 'right',
        stopOnFocus: true,
        style: { background: '#{type == 'notice' ? '#CD853F' : '#DC143C'}' }
      }).showToast();"
    end.join("\n").html_safe
  end
end
