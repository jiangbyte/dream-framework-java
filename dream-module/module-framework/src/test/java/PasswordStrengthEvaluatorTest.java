import io.jiangbyte.framework.utils.PasswordStrengthEvaluator;

/**
 * @author ZhangJiangHu
 * @version v1.0
 * @date 26/11/2025
 * @description TODO
 */
public class PasswordStrengthEvaluatorTest {
    public static void main(String[] args) {
        // 基本使用示例
        String password = "MyPassword123!";
        int strength = PasswordStrengthEvaluator.evaluateStrength(password);
        String description = PasswordStrengthEvaluator.getStrengthDescription(password);

        System.out.println("密码强度等级: " + strength); // 输出: 3
        System.out.println("密码强度描述: " + description); // 输出: 强

        // 检查是否满足最低强度要求
        boolean meetsRequirement = PasswordStrengthEvaluator.meetsStrengthRequirement(password, 2);
        System.out.println("是否满足中等强度: " + meetsRequirement); // 输出: true

        // 获取详细分析报告
        PasswordStrengthEvaluator.StrengthAnalysis analysis =
                PasswordStrengthEvaluator.analyzePassword(password);
        System.out.println(analysis.toString());
    }
}
